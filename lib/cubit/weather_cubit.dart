import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_weather_app/data/model/weather.dart';
import 'package:flutter_bloc_weather_app/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(new WeatherLoading());  // new is already by default
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(
        WeatherError("Couldn't fetch weather. Is the device online?")
      );
    }
  }
}
