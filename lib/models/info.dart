import 'package:cute_weather_v2/models/current.dart';
import 'package:cute_weather_v2/models/daily.dart';
import 'package:cute_weather_v2/models/hourly.dart';

class Info {
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final int timezoneOffset;
  Info(
    this.current,
    this.hourly,
    this.daily,
    this.timezoneOffset,
  );

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      Current.fromJson(json['current'] as Map<String, dynamic>),
      (json['hourly'] as List<dynamic>)
          .map<Hourly>(
            (dynamic json) => Hourly.fromJson(json as Map<String, dynamic>),
          )
          .toList(),
      (json['daily'] as List<dynamic>)
          .map<Daily>(
            (dynamic json) => Daily.fromJson(json as Map<String, dynamic>),
          )
          .toList(),
      json['timezone_offset'] as int,
    );
  }
}
