import 'package:cute_weather_v2/managers/api_manager.dart';
import 'package:cute_weather_v2/managers/shared_prefs_manager.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DI extends StatefulWidget {
  const DI({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<DI> createState() => _DIState();
}

class _DIState extends State<DI> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<ISharedPreferencesManager>(
                create: (context) => SharedPreferencesManager(
                  sharedPreferences: snapshot.data!,
                ),
              ),
              RepositoryProvider<ISharedPreferencesRepository>(
                create: (context) => SharedPreferencesRepository(
                  sharedPreferencesManager:
                      context.read<ISharedPreferencesManager>(),
                ),
              ),
              RepositoryProvider<IApiManager>(
                create: (context) => ApiManager(),
              ),
              RepositoryProvider<IApiRepository>(
                create: (context) => ApiRepository(
                  apiManager: context.read<IApiManager>(),
                ),
              ),
            ],
            child: widget.child,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(),
            ),
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
