import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/search_result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  SearchProvider(
    this._apiServices,
  );

  String _searchQuery = "";
  SearchResultState _resultState = SearchNoneState();

  String get searchQuery => _searchQuery;
  SearchResultState get resultState => _resultState;

  void updateSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();

    if (query.isNotEmpty) {
      fetchSearch(query);
    } else {
      _resultState = SearchNoneState();
      notifyListeners();
    }
  }
  Future<void> fetchSearch(String query) async {
    try {
      _resultState = SearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getSearch(query);

      if (result.error) {
        _resultState = SearchErrorState("Error...");
        notifyListeners();
      } else {
        _resultState = SearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on SocketException {
      _resultState = SearchErrorState("Tidak ada koneksi internet. Silakan periksa jaringan Anda.");
      notifyListeners();
    } catch (e) {
      _resultState = SearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
