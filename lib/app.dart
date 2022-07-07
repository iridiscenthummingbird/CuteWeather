import 'package:cute_weather_v2/di.dart';
import 'package:cute_weather_v2/localization/localization.dart';
import 'package:cute_weather_v2/repositories/api_repository.dart';
import 'package:cute_weather_v2/repositories/shared_prefs_repository.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:cute_weather_v2/screens/home_screen/home_screen.dart';
import 'package:cute_weather_v2/themes/my_themes.dart';
import 'package:cute_weather_v2/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> loadAsync;

  @override
  void initState() {
    super.initState();
    loadAsync = MyI18n.loadTranslations();
  }

  @override
  Widget build(BuildContext context) {
    return DI(
      child: BlocProvider(
        create: (context) => HomeCubit(
          apiRepository: context.read<IApiRepository>(),
          sharedPreferencesRepository: context.read<ISharedPreferencesRepository>(),
        ),
        child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            sharedPreferencesRepository: context.read<ISharedPreferencesRepository>(),
          ),
          child: Builder(builder: (context) {
            return MaterialApp(
              title: 'Cute Weather',
              themeMode: context.watch<ThemeProvider>().themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(
                  future: loadAsync,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return I18n(
                        child: const HomeScreen(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ru', ''),
                Locale('uk'),
              ],
            );
          }),
        ),
      ),
    );
  }
}
