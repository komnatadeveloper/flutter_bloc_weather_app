import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Cubit
// import 'package:flutter_bloc_weather_app/cubit/weather_cubit.dart';
// Bloc
import 'package:flutter_bloc_weather_app/bloc/weather_bloc.dart';
// from data folder
import '../data/model/weather.dart';

class WeatherSearchScreen extends StatefulWidget {
  @override
  _WeatherSearchScreenState createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        // TODO: Implement with cubit
        // child: buildInitialInput(),
        // child: BlocBuilder<WeatherCubit, WeatherState>(
        //   cubit: BlocProvider.of<WeatherCubit>(context), // ALSO POSSIBLE
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (  context, state ) {
            if ( state is WeatherError ) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                )
              );
            }
          },
          builder: ( context, state ) {
            if ( state is WeatherInitial  ) {
              return buildInitialInput();
            } else if ( state is WeatherLoading ) {
              return buildLoading();
            } else if ( state is WeatherLoaded ) {
              return buildColumnWithData(state.weather);
            } else {
              // State is WeatherError
              return buildInitialInput();
            }
          },
        )
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    // TODO: Get weather for the city

    // BlocProvider.of(context)  // This is also a way to use BLOC but old fashion

    final weatherBloc =  context.bloc<WeatherBloc>();
    weatherBloc.add(
      GetWeather(cityName)
    );

  }
}




// class WeatherSearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('WeatherSearchScreen'),),
      
//     );
//   }
// }