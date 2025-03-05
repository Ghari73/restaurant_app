import 'dart:convert';

import 'package:restaurant_app/data/model/post_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/search_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<SearchResponse> getSearch(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return SearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<PostResponse> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "id": id,
        "name": name,
        "review": review,
      }),
    );

    if (response.statusCode == 201) {
      return PostResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
