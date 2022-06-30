part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class FindCityState extends SearchState {
  final City? city;

  FindCityState({required this.city});
}
