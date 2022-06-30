import 'package:bloc/bloc.dart';
import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/models/saved_prefs.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.apiRepository,
    required this.sharedPreferencesRepository,
  }) : super(SearchInitial());
  IApiRepository apiRepository;
  ISharedPreferencesRepository sharedPreferencesRepository;

  Future<void> findCity(String cityName, [String lang = 'en']) async {
    emit(
      FindCityState(
        city: await apiRepository.getCity(cityName, lang),
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
}
