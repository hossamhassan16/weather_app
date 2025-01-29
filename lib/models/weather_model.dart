import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double minTemp;
  double maxTemp;
  String weatherStateName;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.minTemp,
      required this.maxTemp,
      required this.weatherStateName});
  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data["forecast"]["forecastday"][0]["day"];

    //without factory
    // date = data["location"]["localtime"];
    // temp = jsonData["day"]["avgtemp_c"];
    // minTemp = jsonData["day"]["mintemp_c"];
    // maxTemp = jsonData["day"]["maxtemp_c"];
    // weatherStateName = data["current"]["condition"]["text"];
    return WeatherModel(
        date: DateTime.parse(data["location"]["localtime"]),
        temp: jsonData["avgtemp_c"],
        minTemp: jsonData["mintemp_c"],
        maxTemp: jsonData["maxtemp_c"],
        weatherStateName: data["current"]["condition"]["text"]);
  }

  String getImage() {
    if (weatherStateName == "Clear" || weatherStateName == "Light cloud") {
      return "assets/images/clear.png";
    } else if (weatherStateName == "Sleet" ||
        weatherStateName == "Snow" ||
        weatherStateName == "Hail") {
      return "assets/images/snow.png";
    } else if (weatherStateName == "Heavy cloud" ||
        weatherStateName == "Partly cloudy" ||
        weatherStateName == "Mist" ||
        weatherStateName == "Overcast") {
      return "assets/images/cloudy.png";
    } else if (weatherStateName == "Light rain" ||
        weatherStateName == "Heavy rain" ||
        weatherStateName == "Showers") {
      return "assets/images/rainy.png";
    } else if (weatherStateName == "Thunderstorm" ||
        weatherStateName == "Thunder") {
      return "assets/images/thunderstorm.png";
    } else {
      return "assets/images/clear.png";
    }
  }

  MaterialColor getTheme() {
    if (weatherStateName == "Clear" || weatherStateName == "Light cloud") {
      return Colors.orange;
    } else if (weatherStateName == "Sleet" ||
        weatherStateName == "Snow" ||
        weatherStateName == "Hail") {
      return Colors.grey;
    } else if (weatherStateName == "Heavy cloud" ||
        weatherStateName == "Partly cloudy" ||
        weatherStateName == "Mist" ||
        weatherStateName == "Overcast") {
      return Colors.blueGrey;
    } else if (weatherStateName == "Light rain" ||
        weatherStateName == "Heavy rain" ||
        weatherStateName == "Showers") {
      return Colors.deepPurple;
    } else if (weatherStateName == "Thunderstorm" ||
        weatherStateName == "Thunder") {
      return Colors.purple;
    } else {
      return Colors.blue;
    }
  }
}
