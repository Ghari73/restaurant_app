import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/search_response.dart';
import 'package:restaurant_app/data/model/post_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  late ApiServices apiServices;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient((request) async {
      if (request.url.toString().contains('/list')) {
        return http.Response(
          jsonEncode({
            "error": false,
            "message": "success",
            "count": 1,
            "restaurants": []
          }),
          200,
        );
      } else if (request.url.toString().contains('/detail')) {
        return http.Response(
          jsonEncode({
            "error": false,
            "message": "success",
            "restaurant": {}
          }),
          200,
        );
      } else if (request.url.toString().contains('/search')) {
        return http.Response(
          jsonEncode({
            "error": false,
            "message": "success",
            "founded": 1, // 🔥 FIXED
            "restaurants": []
          }),
          200,
        );
      } else if (request.url.toString().contains('/review')) {
        return http.Response(
          jsonEncode({
            "error": false,
            "message": "Review berhasil dikirim",
          }),
          201,
        );
      }
      return http.Response('Not Found', 404);
    });

    apiServices = ApiServices(client: mockClient);
  });

  test('Berhasil mendapatkan daftar restoran', () async {
    final response = await apiServices.getRestaurantList();

    expect(response, isA<RestaurantListResponse>());
    expect(response.error, false);
    expect(response.message, "success");
  });

  test('Gagal mendapatkan daftar restoran', () async {
    mockClient = MockClient((request) async {
      return http.Response('Not Found', 404);
    });

    apiServices = ApiServices(client: mockClient);

    expect(
      () async => await apiServices.getRestaurantList(),
      throwsException,
    );
  });

  test('Berhasil mendapatkan detail restoran', () async {
    final response = await apiServices.getRestaurantDetail("rqdv5juczeskfw1e867");

    expect(response, isA<RestaurantDetailResponse>());
    expect(response.error, false);
    expect(response.message, "success");
  });

  test('Gagal mendapatkan detail restoran', () async {
    mockClient = MockClient((request) async {
      return http.Response('Not Found', 404);
    });

    apiServices = ApiServices(client: mockClient);

    expect(
      () async => await apiServices.getRestaurantDetail("rqdv5juczeskfw1e867"),
      throwsException,
    );
  });

  test('Berhasil melakukan pencarian restoran', () async {
    final response = await apiServices.getSearch("melting");

    expect(response, isA<SearchResponse>());
    expect(response.founded, 1);
  });

  test('Berhasil mengirimkan review restoran', () async {
    final response = await apiServices.postReview(
      id: "rqdv5juczeskfw1e867",
      name: "John Doel",
      review: "Makanan enak banget!",
    );

    expect(response, isA<PostResponse>());
    expect(response.message, 'Review berhasil dikirim');
  });

  test('Gagal mengirimkan review restoran', () async {
    mockClient = MockClient((request) async {
      return http.Response('Not Found', 404);
    });

    apiServices = ApiServices(client: mockClient);

    expect(
      () async => await apiServices.postReview(
        id: "rqdv5juczeskfw1e867",
        name: "John Doe",
        review: "Mantap",
      ),
      throwsException,
    );
  });
}
