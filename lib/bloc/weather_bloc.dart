import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
// from data folder
import '../data/model/weather.dart';
import '../data/weather_repository.dart';
// from BLOC folder
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(
    this._weatherRepository
  ) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if ( event is GetWeather ) {
      // getWeather Method
      try {
        yield (new WeatherLoading());  // new is already by default
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkException {
        yield (
          WeatherError("Couldn't fetch weather. Is the device online?")
        );
      }
      // end of getWeather Method
    }
  }
}
