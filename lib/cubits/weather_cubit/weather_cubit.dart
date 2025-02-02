import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(initialState());
  WeatherService weatherService;
  String? cityName;
  WeatherModel? weatherModel;
  void getWeather({required String cityName}) async {
    emit(weatherLoading());
    try {
      WeatherModel? weatherModel =
          await weatherService.getWeather(cityName: cityName);
      emit(weatherSuccess(weatherModel: weatherModel!));
    } on Exception {
      emit(weatherFailure());
    }
  }
}
