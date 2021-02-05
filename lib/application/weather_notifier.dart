import 'package:revir_pod_pattern/infrastructure/model/weatherModel.dart';
import 'package:revir_pod_pattern/infrastructure/weatherRepository.dart';
import 'package:riverpod/all.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitialize extends WeatherState {
  const WeatherInitialize();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;
  const WeatherLoaded(this.weatherModel);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WeatherLoaded && o.weatherModel == weatherModel;
  }
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WeatherError && o.message == message;
  }
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final IWeatherRepository _iWeatherRepository;
  WeatherNotifier(this._iWeatherRepository) : super(WeatherInitialize());

  Future<void> getWeather(String cityName) async {
    try {
      state = WeatherLoading();
      final weather = await _iWeatherRepository.fetchWeather(cityName);
      state = WeatherLoaded(weather);
    } on NetworkException {
      state = WeatherError("Couldn't fetch weather. Is the device online?");
    }
  }
}
