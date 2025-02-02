import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search a City",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (date) async {
              cityName = date;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: Text("Search"),
              hintText: "Enter a city",
              suffixIcon: GestureDetector(
                  onTap: () async {
                    BlocProvider.of<WeatherCubit>(context)
                        .getWeather(cityName: cityName!);
                    BlocProvider.of<WeatherCubit>(context).cityName = cityName;
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}
