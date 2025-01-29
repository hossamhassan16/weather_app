import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "27aff0bcffa44a97989170345252201";
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url =
          Uri.parse("$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7");
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    // WeatherModel weather = WeatherModel(
    //     date: data["location"]["localtime"],
    //     temp: data["forecast"]["forecastday"]["day"]["avgtemp_c"],
    //     minTemp: data["forecast"]["forecastday"]["day"]["mintemp_c"],
    //     maxTemp: data["forecast"]["forecastday"]["day"]["maxtemp_c"],
    //     weatherStateName: data["current"]["condition"]["text"]);
    return weather;
  }
}
