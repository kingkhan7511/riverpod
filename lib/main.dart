import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:revir_pod_pattern/screens/WeatherScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Weather Search',
        home: WeatherScreen(),
      ),
    );
  }
}
