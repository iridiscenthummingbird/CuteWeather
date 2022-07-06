import 'package:cute_weather_v2/models/info.dart';
import 'package:cute_weather_v2/utils/wind_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class WindAndPressure extends StatelessWidget {
  const WindAndPressure({
    Key? key,
    required this.info,
  }) : super(key: key);
  final Info info;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                    ),
                    angle: vector.radians(info.current.windDeg),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      windDeg(
                        info.current.windDeg,
                        context,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color!.withOpacity(0.54),
                      ),
                    ),
                    Text(
                      '${info.current.windSpeed.toString()} ${'ms'.tr()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'nBeauforts'.tr(
                        namedArgs: {
                          'count': '${getBeaufort(info.current.windSpeed)}',
                        },
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
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'pressure'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).iconTheme.color!.withOpacity(0.54),
                      ),
                    ),
                    Image.asset(
                      'assets/barometer.png',
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      '${info.current.pressure.toString()} ${'mbar'.tr()}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
