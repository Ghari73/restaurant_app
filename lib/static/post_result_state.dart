import 'package:restaurant_app/data/model/post_response.dart';

sealed class PostResultState {}

class PostNoneState extends PostResultState {}

class PostLoadingState extends PostResultState {}

class PostErrorState extends PostResultState {
  final String error;

  PostErrorState(this.error);
}

class PostLoadedState extends PostResultState {
  final PostResponse postResponse;

  PostLoadedState(this.postResponse);
}
