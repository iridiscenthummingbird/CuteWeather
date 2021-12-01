import 'package:cute_weather_v2/models/feels_like.dart';
import 'package:cute_weather_v2/models/temp.dart';
import 'package:cute_weather_v2/models/weather.dart';

class Daily {
  final int dt;
  final Temp temp;
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final Weather weather;

  Daily(
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
  );

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      json['dt'],
      Temp.fromJson(json['temp']),
      FeelsLike.fromJson(json['feels_like']),
      json['pressure'],
      json['humidity'],
      Weather.fromJson(json['weather'][0]),
    );
  }
}
