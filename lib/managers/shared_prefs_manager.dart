import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferencesManager {
  final SharedPreferences sharedPreferences;

  ISharedPreferencesManager({required this.sharedPreferences});

  void setPrefs(SavedPrefs prefs);
  SavedPrefs getPrefs();
}

class SharedPreferencesManager extends ISharedPreferencesManager {
  SharedPreferencesManager({required SharedPreferences sharedPreferences})
      : super(sharedPreferences: sharedPreferences);

  @override
  void setPrefs(SavedPrefs prefs) {
    sharedPreferences.setString("cityName", prefs.cityName);
    sharedPreferences.setDouble("lat", prefs.lat);
    sharedPreferences.setDouble("lon", prefs.lon);
  }

  @override
  SavedPrefs getPrefs() {
    return SavedPrefs(
      cityName: sharedPreferences.getString("cityName") ?? "London",
      lon: sharedPreferences.getDouble("lon") ?? -0.1257,
      lat: sharedPreferences.getDouble("lat") ?? 51.5085,
    );
  }
}
