import 'package:cute_weather_v2/models/cityname_and_offset.dart';
import 'package:cute_weather_v2/screens/home_screen/cubit/home_cubit.dart';
import 'package:cute_weather_v2/utils/date_time_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoaded) {
          final CityNameAndOffset data = state.cityNameAndOffset;
          final String nowDateTime = DateFormat('E Hm', context.locale.languageCode).format(
            DateTimeConverter.convert(
              DateTime.now().millisecondsSinceEpoch ~/ 1000,
              data.offset,
            ),
          );
          return Column(
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                nowDateTime,
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
