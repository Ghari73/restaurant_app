import 'package:restaurant_app/data/model/restaurant.dart';

sealed class SearchResultState {}

class SearchNoneState extends SearchResultState {}

class SearchLoadingState extends SearchResultState {}

class SearchErrorState extends SearchResultState {
  final String error;

  SearchErrorState(this.error);
}

class SearchLoadedState extends SearchResultState {
  final List<Restaurant> data;

  SearchLoadedState(this.data);
}
