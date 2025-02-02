import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

class initialState extends WeatherState {}

class weatherLoading extends WeatherState {}

class weatherSuccess extends WeatherState {
  WeatherModel weatherModel;
  weatherSuccess({required this.weatherModel});
}

class weatherFailure extends WeatherState {}
