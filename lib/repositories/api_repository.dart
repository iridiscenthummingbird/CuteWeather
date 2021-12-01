import 'dart:convert';

import 'package:cute_weather_v2/managers/api_manager.dart';
import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';

abstract class IApiRepository {
  final IApiManager apiManager;

  IApiRepository(this.apiManager);

  Future<Info> getInfo(SavedPrefs savedPrefs, [String lang = "en"]);
  Future<City?> getCity(String cityName, [String lang = "en"]);
}

class ApiRepository extends IApiRepository {
  ApiRepository({required IApiManager apiManager}) : super(apiManager);

  @override
  Future<City?> getCity(String cityName, [String lang = "en"]) async {
    var body = await apiManager.getCity(cityName, lang);
    if (body != null) {
      var parsed = jsonDecode(body);
      return City.fromJson(parsed);
    } else {
      return null;
    }
  }

  @override
  Future<Info> getInfo(SavedPrefs savedPrefs, [String lang = "en"]) async {
    var body = await apiManager.getInfo(lang, savedPrefs);
    var parsed = jsonDecode(body);
    return Info.fromJson(parsed);
  }
}
