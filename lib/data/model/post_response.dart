import 'package:restaurant_app/data/model/restaurant_detail.dart';

class PostResponse {
  final bool error;
  final String message;
  final List<CustomerReviews> customerReviews;

  PostResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReviews>.from(
            json["customerReviews"].map((x) => CustomerReviews.fromJson(x))),
      );
}
