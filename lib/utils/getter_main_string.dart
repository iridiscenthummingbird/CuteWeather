import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GetterMainString {
  static String getMainString(String main, BuildContext context) {
    switch (main) {
      case 'Ash':
        return 'ash'.tr();
      case 'Clear':
        return 'clear'.tr();
      case 'Clouds':
        return 'clouds'.tr();
      case 'Drizzle':
        return 'drizzle'.tr();
      case 'Dust':
        return 'dust'.tr();
      case 'Fog':
        return 'fog'.tr();
      case 'Haze':
        return 'haze'.tr();
      case 'Mist':
        return 'mist'.tr();
      case 'Rain':
        return 'rain'.tr();
      case 'Sand':
        return 'sand'.tr();
      case 'Smoke':
        return 'smoke'.tr();
      case 'Snow':
        return 'snow'.tr();
      case 'Squall':
        return 'squall'.tr();
      case 'Thunderstorm':
        return 'thunderstorm'.tr();
      case 'Tornado':
        return 'tornado'.tr();
      default:
        throw UnimplementedError('MainStringError');
    }
  }
}
