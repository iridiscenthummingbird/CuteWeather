import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetterMainString {
  static String getMainString(String main, BuildContext context) {
    var dictionary = AppLocalizations.of(context)!;
    switch (main) {
      case "Ash":
        return dictionary.ash;
      case "Clear":
        return dictionary.clear;
      case "Clouds":
        return dictionary.clouds;
      case "Drizzle":
        return dictionary.drizzle;
      case "Dust":
        return dictionary.dust;
      case "Fog":
        return dictionary.fog;
      case "Haze":
        return dictionary.haze;
      case "Mist":
        return dictionary.mist;
      case "Rain":
        return dictionary.rain;
      case "Sand":
        return dictionary.sand;
      case "Smoke":
        return dictionary.smoke;
      case "Snow":
        return dictionary.snow;
      case "Squall":
        return dictionary.squall;
      case "Thunderstorm":
        return dictionary.thunderstorm;
      case "Tornado":
        return dictionary.tornado;
      default:
        throw UnimplementedError("MainStringError");
    }
  }
}
