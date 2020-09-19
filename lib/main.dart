import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weather_app/cubit/weather_cubit.dart';
import 'package:flutter_bloc_weather_app/data/weather_repository.dart';
// Screens
import './screens/weather_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: BlocProvider(
        // create: ( context ) => WeatherCubit(  // for Cubit
        create: ( context ) => WeatherBloc(
          FakeWeatherRepository()
        ),
        child: WeatherSearchScreen()
      ),
    );
  }
}


// class MyState {
//   final int field1;
//   final String field2;
//   MyState(
//     this.field1,
//     this.field2
//   );
// }

// class MyCubit extends Cubit<MyState> {
//   MyCubit() : super(MyState(0, 'Initial value'));

//   void changeState() {
//     emit(
//       MyState( 0, 'New Value' )
//     );
//   }
// }



