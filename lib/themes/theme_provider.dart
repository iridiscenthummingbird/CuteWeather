import 'package:flutter/material.dart';

import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;
  ISharedPreferencesRepository sharedPreferencesRepository;
  ThemeProvider({
    required this.sharedPreferencesRepository,
  }) {
    themeMode = sharedPreferencesRepository.getTheme();
  }
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    sharedPreferencesRepository.setTheme(themeMode);
    notifyListeners();
  }
}
