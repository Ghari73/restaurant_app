import 'package:restaurant_app/data/model/restaurant.dart';

class SearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      error: json["error"],
      founded: json["founded"],
      restaurants: json["restaurants"] != null
          ? List<Restaurant>.from(
              json["restaurants"]!.map((x) => Restaurant.fromJson(x)))
          : <Restaurant>[],
    );
  }
}
