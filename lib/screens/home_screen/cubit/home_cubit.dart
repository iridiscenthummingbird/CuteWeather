import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.apiRepository,
    required this.sharedPreferencesRepository,
  }) : super(HomeInitial());

  final IApiRepository apiRepository;
  final ISharedPreferencesRepository sharedPreferencesRepository;

  final StreamController<String> _cityNameStreamController =
      StreamController<String>();
  Stream<String> get cityNameStream => _cityNameStreamController.stream;

  final StreamController<Info> _infoStreamController = StreamController<Info>();
  Stream<Info> get infoStream => _infoStreamController.stream;

  void getData([String lang = 'en']) async {
    SavedPrefs prefs = sharedPreferencesRepository.getPrefs();
    _infoStreamController.add(await apiRepository.getInfo(prefs, lang));
    _cityNameStreamController.add(prefs.cityName);
  }

  Future<City?> findCity(String cityName, [String lang = "en"]) async {
    return await apiRepository.getCity(cityName, lang);
  }

  void saveCity(City city) {
    sharedPreferencesRepository.setPrefs(
      SavedPrefs(
        cityName: city.name,
        lon: city.lon,
        lat: city.lat,
      ),
    );
  }
}
