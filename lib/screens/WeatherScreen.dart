import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:revir_pod_pattern/application/weather_notifier.dart';
import 'package:revir_pod_pattern/infrastructure/model/weatherModel.dart';
import 'package:revir_pod_pattern/providers.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: ProviderListener(
          provider: weatherNotifierProvider.state,
          onChange: (context, state) {
            if (state is WeatherError) {
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Consumer(
            builder: (context, watch, child) {
              final state = watch(weatherNotifierProvider.state);
              if (state is WeatherInitialize) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weatherModel);
              } else {
                return buildInitialInput();
              }
            },
          ),
        ),
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

  Widget buildColumnWithData(WeatherModel weatherModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weatherModel.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weatherModel.teampretureCelsius.toString()} °C",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 50,
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onSubmitted: (value) => submitInputValue(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: 'Search City',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }

  void submitInputValue(BuildContext context, String searchText) {
    context.read(weatherNotifierProvider).getWeather(searchText);
  }
}
