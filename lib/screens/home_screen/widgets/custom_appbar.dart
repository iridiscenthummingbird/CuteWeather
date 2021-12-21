import 'package:cute_weather_v2/models/cityname_and_offset.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:cute_weather_v2/utils/date_time_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CityNameAndOffset>(
      stream: context.read<HomeCubit>().cityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(
                snapshot.data!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.nowDateTime(
                  DateTimeConverter.convert(
                    DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    snapshot.data!.offset,
                  ),
                  DateTimeConverter.convert(
                    DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    snapshot.data!.offset,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
