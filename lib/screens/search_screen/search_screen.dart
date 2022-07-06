import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:cute_weather_v2/screens/search_screen/cubit/search_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCubit _cubit;

  City? foundedCity;

  @override
  void initState() {
    _cubit = SearchCubit(
      apiRepository: context.read<IApiRepository>(),
      sharedPreferencesRepository: context.read<ISharedPreferencesRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        hint: 'search'.tr(),
        onQueryChanged: (query) async {
          await _cubit.findCity(
            query,
            'localeName'.tr(),
          );
        },
        builder: (context, transition) {
          return BlocBuilder(
            bloc: _cubit,
            builder: (context, state) {
              if (state is FindCityState) {
                foundedCity = state.city;
              } else {
                foundedCity = null;
              }
              if (foundedCity != null) {
                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Theme.of(context).cardColor,
                      elevation: 0.0,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/${foundedCity!.weather.icon}.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Text(
                          foundedCity!.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          '${foundedCity!.temp.round()}°',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          _cubit.saveCity(foundedCity!);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
