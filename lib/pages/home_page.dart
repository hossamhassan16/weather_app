import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: BlocProvider.of<WeatherCubit>(context).weatherModel ==
                null
            ? Colors.blue
            : BlocProvider.of<WeatherCubit>(context).weatherModel!.getTheme(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, State) {
          if (State is weatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (State is weatherSuccess) {
            return SuccessBody(weatherData: State.weatherModel);
          } else if (State is weatherFailure) {
            return Center(
              child: Text("Something went wrong,please try again"),
            );
          } else {
            return DefaultBody();
          }
        },
      ),
    );
  }
}

class DefaultBody extends StatelessWidget {
  const DefaultBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "There is no weather 😔",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            "start searching now🔎",
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              weatherData!.getTheme(),
              weatherData!.getTheme()[300]!,
              weatherData!.getTheme()[100]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Text(
              BlocProvider.of<WeatherCubit>(context).cityName!,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Updated at: ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(weatherData!.getImage()),
                Text(
                  "${weatherData!.temp.toInt()}",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "min temp : ${weatherData!.minTemp.toInt()}",
                    ),
                    Text(
                      "max temp : ${weatherData!.maxTemp.toInt()}",
                    ),
                  ],
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              weatherData?.weatherStateName ?? "",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(
              flex: 5,
            )
          ],
        ),
      ),
    );
  }
}
