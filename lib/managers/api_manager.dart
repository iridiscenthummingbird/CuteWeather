import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:cute_weather_v2/utils/keys.dart';
import 'package:http/http.dart' as http;

abstract class IApiManager {
  final String _key = Keys.apiKey;
  Future<String> getInfo(String lang, SavedPrefs savedPrefs);
  Future<String?> getCity(String cityName, [String lang = 'en']);
  Future<String?> getCityFromCoords(
    double lon,
    double lat, [
    String lang = 'en',
  ]);
}

class ApiManager extends IApiManager {
  @override
  Future<String?> getCity(String cityName, [String lang = 'en']) async {
    final url =
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_key&units=metric&lang=$lang');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Future<String?> getCityFromCoords(
    double lon,
    double lat, [
    String lang = 'en',
  ]) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_key&units=metric&lang=$lang',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Future<String> getInfo(String lang, SavedPrefs savedPrefs) async {
    final double lat = savedPrefs.lat;
    final double lon = savedPrefs.lon;
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$_key&units=metric&exclude=minutely&lang=$lang');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Error';
    }
  }
}
