import 'package:cute_weather_v2/models/info.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Info info;

  String uvi(int val, BuildContext context) {
    if (val >= 0 && val <= 2) {
      return AppLocalizations.of(context)!.low;
    } else if (val >= 3 && val <= 5) {
      return AppLocalizations.of(context)!.moderate;
    } else if (val >= 6 && val <= 7) {
      return AppLocalizations.of(context)!.high;
    } else if (val >= 8 && val <= 10) {
      return AppLocalizations.of(context)!.veryHigh;
    } else if (val >= 11) {
      return AppLocalizations.of(context)!.extreme;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color.fromARGB(75, 214, 214, 214)),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/${info.current.weather.icon}.png',
                      height: 64,
                      width: 64, //TODO: увеличить размер всех картинок
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/humidity.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.humidity,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              '${info.current.humidity.toString()}%',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: DottedLine(
                          dashColor: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      Tooltip(
                        message: uvi(
                          info.current.uvi.round(),
                          context,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      'assets/sun.png',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.uvIndex,
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Text(
                                info.current.uvi.toString(),
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: DottedLine(
                          dashColor: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/eye.png',
                                    height: 16,
                                    width: 16,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.visibility,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              '${info.current.visibility / 1000} ${AppLocalizations.of(context)!.km}',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: DottedLine(
                          dashColor: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/dew_point.png',
                                    height: 16,
                                    width: 16,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dewPoint,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              '${info.current.dewPoint.round()}°',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: DottedLine(
                          dashColor: Theme.of(context).iconTheme.color!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'assets/03d.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.clouds,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              '${info.current.clouds}%',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
