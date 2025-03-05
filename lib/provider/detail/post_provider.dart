import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/post_result_state.dart';

class PostProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  PostProvider(
    this._apiServices,
  );

  PostResultState _resultState = PostNoneState();

  PostResultState get resultState => _resultState;

  Future<void> postReview(String id, String name, String review) async {
    try {
      _resultState = PostLoadingState();
      notifyListeners();

      final result =
          await _apiServices.postReview(id: id, name: name, review: review);

      if (result.error) {
        _resultState = PostErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = PostLoadedState(result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = PostErrorState(e.toString());
      notifyListeners();
    }
  }
}
