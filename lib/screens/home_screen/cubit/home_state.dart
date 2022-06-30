part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeDataLoaded extends HomeState {
  final CityNameAndOffset cityNameAndOffset;
  final Info info;

  HomeDataLoaded({
    required this.cityNameAndOffset,
    required this.info,
  });
}
