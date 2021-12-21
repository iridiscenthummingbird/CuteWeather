import 'package:cute_weather_v2/models/hourly.dart';
import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/utils/date_time_converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourList extends StatelessWidget {
  const HourList({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Info info;

  @override
  Widget build(BuildContext context) {
    final List<Hourly> hourly = info.hourly;
    final int offset = info.timezoneOffset;
    return SizedBox(
      height: 115,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(75, 214, 214, 214),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: 24,
            itemBuilder: (context, i) {
              return Padding(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        DateFormat.Hm().format(
                          DateTimeConverter.convert(hourly[i].dt, offset),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).iconTheme.color!.withOpacity(0.54),
                        ),
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
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
