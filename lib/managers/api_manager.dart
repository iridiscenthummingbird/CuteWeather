import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:http/http.dart' as http;

abstract class IApiManager {
  final String _key = "e6d4c6f3d7776b0dc0b1d4cffbdb90fd";
  Future<String> getInfo(String lang, SavedPrefs savedPrefs);
  Future<String?> getCity(String cityName, [String lang = "en"]);
}

class ApiManager extends IApiManager {
  @override
  Future<String?> getCity(String cityName, [String lang = "en"]) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_key&units=metric&lang=$lang');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Future<String> getInfo(String lang, SavedPrefs savedPrefs) async {
    double lat = savedPrefs.lat;
    double lon = savedPrefs.lon;
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$_key&units=metric&exclude=minutely&lang=$lang');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error";
    }
  }
}
