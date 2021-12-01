import 'package:cute_weather_v2/models/weather.dart';

class Current {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final Weather weather;
  final double windDeg;
  final double windSpeed;
  final double dewPoint;
  final double uvi;
  final double clouds;
  final double visibility;

  Current(
    this.dt,
    this.temp,
    this.feelsLike,
    this.windDeg,
    this.windSpeed,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.pressure,
    this.humidity,
    this.weather,
  );

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      json['dt'],
      double.parse(json['temp'].toString()),
      double.parse(json['feels_like'].toString()),
      double.parse(json['wind_deg'].toString()),
      double.parse(json['wind_speed'].toString()),
      double.parse(json['dew_point'].toString()),
      double.parse(json['uvi'].toString()),
      double.parse(json['clouds'].toString()),
      double.parse(json['visibility'].toString()),
      json['pressure'],
      json['humidity'],
      Weather.fromJson(json['weather'][0]),
    );
  }
}
