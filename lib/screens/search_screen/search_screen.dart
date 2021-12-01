import 'dart:async';

import 'package:cute_weather_v2/models/city.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late HomeCubit _cubit;
  late StreamController<City?> _controller;

  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    _controller = StreamController<City>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        hint: AppLocalizations.of(context)!.search,
        onQueryChanged: (query) async {
          var result = await _cubit.findCity(
            query,
            AppLocalizations.of(context)!.localeName,
          );
          if (result == null) {
            _controller.addError("Error");
          } else {
            _controller.add(result);
          }
        },
        builder: (context, transition) {
          return StreamBuilder<City?>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var city = snapshot.data!;
                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Theme.of(context).cardColor,
                      elevation: 0.0,
                      child: ListTile(
                        leading: Image.asset(
                          'assets/${city.weather.icon}.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Text(
                          city.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "${city.temp.round()}°",
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          _cubit.saveCity(city);
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
