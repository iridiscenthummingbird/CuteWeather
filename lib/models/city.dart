import 'package:cute_weather_v2/models/weather.dart';

class City {
  final double lat;
  final double lon;
  final Weather weather;
  final String name;
  final double temp;

  City(
    this.lat,
    this.lon,
    this.weather,
    this.name,
    this.temp,
  );

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      double.parse(json['coord']['lat'].toString()),
      double.parse(json['coord']['lon'].toString()),
      Weather.fromJson(json['weather'][0]),
      json['name'],
      double.parse(json['main']['temp'].toString()),
    );
  }
}
