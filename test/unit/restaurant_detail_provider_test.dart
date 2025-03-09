import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'mocks.mocks.dart';

void main() {
  late RestaurantDetailProvider provider;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestaurantDetailProvider(mockApiService);
  });

  final mockRestaurantDetail = RestaurantDetailResponse(
    error: false,
    message: "Success",
    restaurant: RestaurantDetail(
      id: "r1",
      name: "Test Restaurant",
      description: "A nice place",
      city: "Jakarta",
      rating: 4.5,
      pictureId: "image.jpg",
      address: "Jl. Test No. 1",
      categories: [],
      menus: Menus(foods: [], drinks: []),
      customerReviews: [],
    ),
  );

  test('Memeriksa fetching detail restoran berhasil', () async {
    when(mockApiService.getRestaurantDetail(any))
        .thenAnswer((_) async => mockRestaurantDetail);

    await provider.fetchRestaurantDetail("r1");

    expect(provider.resultState, isA<RestaurantDetailLoadedState>());
  });

  test('Memeriksa fetching detail restoran gagal (API error)', () async {
    final errorResponse = RestaurantDetailResponse(
      error: true,
      message: "Data tidak ditemukan",
      restaurant: RestaurantDetail(
        id: "",
        name: "",
        description: "",
        city: "",
        rating: 0,
        pictureId: "",
        address: "",
        categories: [],
        menus: Menus(foods: [], drinks: []),
        customerReviews: [],
      ),
    );

    when(mockApiService.getRestaurantDetail(any))
        .thenAnswer((_) async => errorResponse);

    await provider.fetchRestaurantDetail("r1");

    expect(provider.resultState, isA<RestaurantDetailErrorState>());
    expect((provider.resultState as RestaurantDetailErrorState).error,
        "Data tidak ditemukan");
  });

  test(
      'Memeriksa fetching detail restoran gagal karena tidak ada koneksi internet',
      () async {
    when(mockApiService.getRestaurantDetail(any))
        .thenThrow(SocketException("No Internet"));

    await provider.fetchRestaurantDetail("r1");

    expect(provider.resultState, isA<RestaurantDetailErrorState>());
    expect((provider.resultState as RestaurantDetailErrorState).error,
        "Tidak ada koneksi internet. Silakan periksa jaringan Anda.");
  });

  test('Memeriksa fetching detail restoran gagal karena exception lainnya',
      () async {
    when(mockApiService.getRestaurantDetail(any))
        .thenThrow(Exception("Unknown Error"));

    await provider.fetchRestaurantDetail("r1");

    expect(provider.resultState, isA<RestaurantDetailErrorState>());
    expect((provider.resultState as RestaurantDetailErrorState).error,
        "Exception: Unknown Error");
  });
}
