import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/models/cityname_and_offset.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.apiRepository,
    required this.sharedPreferencesRepository,
  }) : super(HomeInitial());

  final IApiRepository apiRepository;
  final ISharedPreferencesRepository sharedPreferencesRepository;

  Future<void> getData([String lang = 'en']) async {
    final SavedPrefs prefs = sharedPreferencesRepository.getPrefs();
    emit(
      HomeDataLoaded(
        cityNameAndOffset: CityNameAndOffset(
          prefs.cityName,
          prefs.offset,
        ),
        info: await apiRepository.getInfo(prefs, lang),
      ),
    );
  }

  void saveCity(City city) {
    sharedPreferencesRepository.setPrefs(
      SavedPrefs(
        cityName: city.name,
        lon: city.lon,
        lat: city.lat,
        offset: city.timezoneOffset,
      ),
    );
  }

  Future<void> getInfoFromCoords(String lang) async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    saveCity(
      (await apiRepository.getCityFromCoords(
        _locationData.longitude!,
        _locationData.latitude!,
        lang,
      ))!,
    );
    getData(lang);
  }
}
