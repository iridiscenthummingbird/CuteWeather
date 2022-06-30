import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/custom_appbar.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/custom_drawer.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/custom_tooltip.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/day_list.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/details.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/hour_list.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/subtitle.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/wind_and_pressure.dart';
import 'package:cute_weather_v2/screens/search_screen/search_screen.dart';
import 'package:cute_weather_v2/utils/getter_main_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;
  @override
  void initState() {
    _cubit = context.read<HomeCubit>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _cubit.getData(AppLocalizations.of(context)!.localeName);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        foregroundColor: Theme.of(context).iconTheme.color,
        title: BlocProvider.value(
          value: _cubit,
          child: const CustomAppbar(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.location_on_outlined,
              size: 30.0,
            ),
            onPressed: () {
              _cubit.getInfoFromCoords(
                AppLocalizations.of(context)!.localeName,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              ).then(
                (value) => _cubit.getData(AppLocalizations.of(context)!.localeName),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _cubit.getData(),
        child: BlocBuilder(
          bloc: _cubit,
          builder: (context, state) {
            if (state is HomeDataLoaded) {
              final Info info = state.info;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            GetterMainString.getMainString(
                              info.current.weather.main,
                              context,
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            child: Image.asset(
                              'assets/${info.current.weather.icon}.png',
                              width: 30,
                              height: 30,
                            ),
                            padding: const EdgeInsets.only(left: 10),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${info.current.temp.round()}°',
                                style: const TextStyle(fontSize: 52),
                              ),
                              const Text(
                                'C',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                          CustomTooltip(
                            message: AppLocalizations.of(context)!.pressure,
                            value: info.current.pressure,
                            image: 'assets/barometer.png',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.feelsLike} ${info.current.feelsLike.round()}°C',
                            style: const TextStyle(fontSize: 14),
                          ),
                          CustomTooltip(
                            message: AppLocalizations.of(context)!.humidity,
                            value: info.current.humidity,
                            image: 'assets/humidity.png',
                          ),
                        ],
                      ),
                      Subtitle(
                        subtitle: AppLocalizations.of(context)!.hourlyForecast,
                      ),
                      HourList(info: info),
                      Subtitle(
                        subtitle: AppLocalizations.of(context)!.dailyForecast,
                      ),
                      DayList(info: info),
                      Subtitle(
                        subtitle: AppLocalizations.of(context)!.windAndPressure,
                      ),
                      WindAndPressure(info: info),
                      Subtitle(
                        subtitle: AppLocalizations.of(context)!.details,
                      ),
                      DetailsWidget(
                        info: info,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
