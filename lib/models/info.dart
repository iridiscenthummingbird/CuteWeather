import 'package:cute_weather_v2/models/current.dart';
import 'package:cute_weather_v2/models/daily.dart';
import 'package:cute_weather_v2/models/hourly.dart';

class Info {
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  Info(
    this.current,
    this.hourly,
    this.daily,
  );

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      Current.fromJson(json['current']),
      json['hourly'].map<Hourly>((json) => Hourly.fromJson(json)).toList(),
      json['daily'].map<Daily>((json) => Daily.fromJson(json)).toList(),
    );
  }
}
