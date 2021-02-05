import 'dart:math';

import 'package:revir_pod_pattern/infrastructure/model/weatherModel.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> fetchWeather(String cityName);
}

class WeatherRepository extends IWeatherRepository {
  double cachedTempCalsius;
  @override
  Future<WeatherModel> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = new Random();
        if (random.nextBool()) {
          throw NetworkException();
        }
        cachedTempCalsius = 20 + random.nextInt(15) + random.nextDouble();

        return WeatherModel(
            cityName: cityName,
            // Temperature between 20 and 35.99
            teampretureCelsius: cachedTempCalsius);
      },
    );
  }
}

class NetworkException implements Exception {}
