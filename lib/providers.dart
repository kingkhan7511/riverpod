import 'package:revir_pod_pattern/application/weather_notifier.dart';
import 'package:revir_pod_pattern/infrastructure/weatherRepository.dart';
import 'package:riverpod/all.dart';

final weatherRepositoryProvider = Provider<IWeatherRepository>(
  (ref) => WeatherRepository(),
);

final weatherNotifierProvider = StateNotifierProvider(
    (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)));
