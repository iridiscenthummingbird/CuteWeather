import 'dart:convert';

import 'package:cute_weather_v2/managers/api_manager.dart';
import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';

abstract class IApiRepository {
  final IApiManager apiManager;

  IApiRepository(this.apiManager);

  Future<Info> getInfo(SavedPrefs savedPrefs, [String lang = 'en']);
  Future<City?> getCity(String cityName, [String lang = 'en']);
  Future<City?> getCityFromCoords(
    double lon,
    double lat, [
    String lang = 'en',
  ]);
}

class ApiRepository extends IApiRepository {
  ApiRepository({required IApiManager apiManager}) : super(apiManager);

  @override
  Future<City?> getCity(String cityName, [String lang = 'en']) async {
    final body = await apiManager.getCity(cityName, lang);
    if (body != null) {
      final parsed = jsonDecode(body) as Map<String, dynamic>;
      return City.fromJson(parsed);
    } else {
      return null;
    }
  }

  @override
  Future<Info> getInfo(SavedPrefs savedPrefs, [String lang = 'en']) async {
    final body = await apiManager.getInfo(lang, savedPrefs);
    final parsed = jsonDecode(body) as Map<String, dynamic>;
    return Info.fromJson(parsed);
  }

  @override
  Future<City?> getCityFromCoords(double lon, double lat, [String lang = 'en']) async {
    final body = await apiManager.getCityFromCoords(lon, lat, lang);
    if (body != null) {
      final parsed = jsonDecode(body) as Map<String, dynamic>;
      return City.fromJson(parsed);
    } else {
      return null;
    }
  }
}
