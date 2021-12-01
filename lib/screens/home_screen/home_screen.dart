import 'package:cute_weather_v2/models/daily.dart';
import 'package:cute_weather_v2/models/hourly.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:cute_weather_v2/screens/home_screen/widgets/details.dart';
import 'package:cute_weather_v2/screens/search_screen/search_screen.dart';
import 'package:cute_weather_v2/services/getter_main_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math.dart' as vector;

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
    Future.delayed(Duration.zero, () {
      _cubit.getData(AppLocalizations.of(context)!.localeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: StreamBuilder<String>(
          stream: _cubit.cityNameStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    snapshot.data ?? "",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.nowDateTime(
                      DateTime.now(),
                      DateTime.now(),
                    ),
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              ).then(
                (value) =>
                    _cubit.getData(AppLocalizations.of(context)!.localeName),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _cubit.getData(),
        child: StreamBuilder<Info>(
          stream: _cubit.infoStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Info info = snapshot.data!;
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
                                "${info.current.temp.round()}°",
                                style: const TextStyle(fontSize: 52),
                              ),
                              const Text(
                                'C',
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                          Tooltip(
                              message: AppLocalizations.of(context)!.pressure,
                              child: Row(
                                children: [
                                  Text(
                                    info.current.pressure.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Padding(
                                    child: Image.asset(
                                      'assets/barometer.png',
                                      height: 14,
                                      width: 14,
                                    ),
                                    padding: const EdgeInsets.only(left: 5.0),
                                  )
                                ],
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.feelsLike} ${info.current.feelsLike.round()}°C",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Tooltip(
                            message: AppLocalizations.of(context)!.humidity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  info.current.humidity.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Padding(
                                  child: Image.asset(
                                    'assets/humidity.png',
                                    height: 14,
                                    width: 14,
                                  ),
                                  padding: const EdgeInsets.only(left: 5.0),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: Align(
                          child: Text(
                            AppLocalizations.of(context)!.hourlyForecast,
                            style: const TextStyle(fontSize: 20),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      SizedBox(
                        height: 115,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(75, 214, 214, 214),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListView(
                              children: getHourList(info.hourly),
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Align(
                          child: Text(
                            AppLocalizations.of(context)!.dailyForecast,
                            style: const TextStyle(fontSize: 20),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: getDailyList(info.daily),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Align(
                            child: Text(
                              AppLocalizations.of(context)!.windAndPressure,
                              style: const TextStyle(fontSize: 20),
                            ),
                            alignment: Alignment.centerLeft,
                          )),
                      SizedBox(
                        height: 110,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(75, 214, 214, 214),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                      child: Image.asset(
                                        'assets/down-arrow.png',
                                      ),
                                      angle:
                                          vector.radians(info.current.windDeg),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, bottom: 7),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        windDeg(
                                          info.current.windDeg,
                                          context,
                                        ),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "${info.current.windSpeed.toString()} ${AppLocalizations.of(context)!.ms}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .nBeauforts(
                                          getBeaufort(info.current.windSpeed),
                                        ),
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: Colors.black45,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, bottom: 7),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.pressure,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black54),
                                      ),
                                      Image.asset(
                                        'assets/barometer.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Text(
                                        "${info.current.pressure.toString()} ${AppLocalizations.of(context)!.mbar}",
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Align(
                          child: Text(
                            AppLocalizations.of(context)!.details,
                            style: const TextStyle(fontSize: 20),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      DetailsWidget(
                        info: info,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  List<Widget> getHourList(List<Hourly> hourly) {
    List<Widget> hourList = [];
    for (int i = 0; i < 24; i++) {
      hourList.add(
        Padding(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  DateFormat.Hm().format(
                    DateTime.fromMillisecondsSinceEpoch(hourly[i].dt * 1000),
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/${hourly[i].weather.icon}.png',
                    width: 41,
                    height: 41,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "${hourly[i].temp.round()}°",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(right: 10, left: i == 0 ? 10 : 0),
        ),
      );
    }
    return hourList;
  }

  List<Widget> getDailyList(List<Daily> daily) {
    List<Widget> dayList = [];
    int i = 0;
    for (var item in daily) {
      dayList.add(
        Padding(
          padding: EdgeInsets.only(right: i < 7 ? 10 : 0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(75, 214, 214, 214)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    AppLocalizations.of(context)!.dayOfWeek(
                      DateTime.fromMillisecondsSinceEpoch(item.dt * 1000),
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    AppLocalizations.of(context)!.monthAndDay(
                      DateTime.fromMillisecondsSinceEpoch(item.dt * 1000),
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/${item.weather.icon}.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                Text(
                  "${AppLocalizations.of(context)!.highTemp}: ${item.temp.max.round()}°C",
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  "${AppLocalizations.of(context)!.lowTemp}: ${item.temp.min.round()}°C",
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      );
      i++;
    }
    return dayList;
  }

  String windDeg(double deg, BuildContext context) {
    if (deg >= 22.5 && deg < 67.5) {
      return AppLocalizations.of(context)!.sw;
    } else if (deg >= 67.5 && deg < 112.5) {
      return AppLocalizations.of(context)!.w;
    } else if (deg >= 112.5 && deg < 157.5) {
      return AppLocalizations.of(context)!.nw;
    } else if (deg >= 157.5 && deg < 202.5) {
      return AppLocalizations.of(context)!.n;
    } else if (deg >= 202.5 && deg < 247.5) {
      return AppLocalizations.of(context)!.ne;
    } else if (deg >= 247.5 && deg < 292.5) {
      return AppLocalizations.of(context)!.e;
    } else if (deg >= 292.5 && deg < 337.5) {
      return AppLocalizations.of(context)!.se;
    } else {
      return AppLocalizations.of(context)!.s;
    }
  }

  int getBeaufort(double speed) {
    if (speed < 0.5) {
      return 0;
    } else if (speed >= 0.5 && speed < 1.5) {
      return 1;
    } else if (speed >= 1.5 && speed < 3.3) {
      return 2;
    } else if (speed >= 3.3 && speed < 5.5) {
      return 3;
    } else if (speed >= 5.5 && speed < 7.9) {
      return 4;
    } else if (speed >= 7.9 && speed < 10.7) {
      return 5;
    } else if (speed >= 10.7 && speed < 13.8) {
      return 6;
    } else if (speed >= 13.9 && speed < 17.1) {
      return 7;
    } else if (speed >= 17.2 && speed < 20.7) {
      return 8;
    } else if (speed >= 20.7 && speed < 24.4) {
      return 9;
    } else if (speed >= 24.4 && speed < 28.4) {
      return 10;
    } else if (speed >= 28.4 && speed < 32.6) {
      return 11;
    } else {
      return 12;
    }
  }
}
