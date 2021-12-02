import 'package:cute_weather_v2/managers/shared_prefs_manager.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:flutter/material.dart';

abstract class ISharedPreferencesRepository {
  final ISharedPreferencesManager sharedPreferencesManager;

  ISharedPreferencesRepository({required this.sharedPreferencesManager});

  void setPrefs(SavedPrefs prefs);
  SavedPrefs getPrefs();

  void setTheme(ThemeMode themeMode);
  ThemeMode getTheme();
}

class SharedPreferencesRepository extends ISharedPreferencesRepository {
  SharedPreferencesRepository(
      {required ISharedPreferencesManager sharedPreferencesManager})
      : super(sharedPreferencesManager: sharedPreferencesManager);

  @override
  SavedPrefs getPrefs() {
    return sharedPreferencesManager.getPrefs();
  }

  @override
  void setPrefs(SavedPrefs prefs) {
    sharedPreferencesManager.setPrefs(prefs);
  }

  @override
  ThemeMode getTheme() {
    return sharedPreferencesManager.getTheme();
  }

  @override
  void setTheme(ThemeMode themeMode) {
    sharedPreferencesManager.setTheme(themeMode);
  }
}
