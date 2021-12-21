import 'package:cute_weather_v2/models/daily.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/utils/date_time_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayList extends StatelessWidget {
  const DayList({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Info info;

  @override
  Widget build(BuildContext context) {
    List<Daily> daily = info.daily;
    int offset = info.timezoneOffset;
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daily.length,
        itemBuilder: (context, i) {
          Daily item = daily[i];
          return Padding(
            padding: EdgeInsets.only(right: i < 7 ? 10 : 0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(75, 214, 214, 214)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      AppLocalizations.of(context)!.dayOfWeek(
                        DateTimeConverter.convert(item.dt, offset),
                      ),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      AppLocalizations.of(context)!.monthAndDay(
                        DateTimeConverter.convert(item.dt, offset),
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
          );
        },
      ),
    );
  }
}
