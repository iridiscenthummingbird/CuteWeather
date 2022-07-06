import 'package:cute_weather_v2/models/info.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  final Info info;

  String uvi(int val, BuildContext context) {
    if (val >= 0 && val <= 2) {
      return 'low'.tr();
    } else if (val >= 3 && val <= 5) {
      return 'moderate'.tr();
    } else if (val >= 6 && val <= 7) {
      return 'high'.tr();
    } else if (val >= 8 && val <= 10) {
      return 'veryHigh'.tr();
    } else if (val >= 11) {
      return 'extreme'.tr();
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
                                  'humidity'.tr(),
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
                                    'uvIndex'.tr(),
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
                                  'visibility'.tr(),
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Text(
                              '${info.current.visibility / 1000} ${'km'.tr()}',
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
                                  'dewPoint'.tr(),
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
                                  'clouds'.tr(),
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
