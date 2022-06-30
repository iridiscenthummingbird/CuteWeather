import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesManager {
  final SharedPreferences sharedPreferences;

  ISharedPreferencesManager({required this.sharedPreferences});

  void setPrefs(SavedPrefs prefs);
  SavedPrefs getPrefs();

  void setTheme(ThemeMode themeMode);
  ThemeMode getTheme();
}

class SharedPreferencesManager extends ISharedPreferencesManager {
  SharedPreferencesManager({required SharedPreferences sharedPreferences})
      : super(sharedPreferences: sharedPreferences);

  @override
  void setPrefs(SavedPrefs prefs) {
    sharedPreferences.setString('cityName', prefs.cityName);
    sharedPreferences.setDouble('lat', prefs.lat);
    sharedPreferences.setDouble('lon', prefs.lon);
    sharedPreferences.setInt('offset', prefs.offset);
  }

  @override
  SavedPrefs getPrefs() {
    return SavedPrefs(
      cityName: sharedPreferences.getString('cityName') ?? 'London',
      lon: sharedPreferences.getDouble('lon') ?? -0.1257,
      lat: sharedPreferences.getDouble('lat') ?? 51.5085,
      offset: sharedPreferences.getInt('offset') ?? 0,
    );
  }

  @override
  ThemeMode getTheme() {
    final theme = sharedPreferences.getString('theme');
    if (theme == null) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      final bool isDarkMode = brightness == Brightness.dark;
      if (isDarkMode) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else if (theme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  @override
  void setTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      sharedPreferences.setString('theme', 'dark');
    } else {
      sharedPreferences.setString('theme', 'light');
    }
  }
}
