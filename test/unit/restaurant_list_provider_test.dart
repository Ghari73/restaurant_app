import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'mocks.mocks.dart';

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApiService;

  setUp(() {
    mockApiService = MockApiServices();
    provider = RestaurantListProvider(mockApiService);
  });

  test('Memeriksa fetching daftar restoran berhasil', () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      count: 1,
      message: "Success",
      restaurants: [],
    );

    when(mockApiService.getRestaurantList())
        .thenAnswer((_) async => Future.value(mockResponse));

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListLoadedState>());
  });

  test('Memeriksa fetching daftar restoran gagal', () async {
    final mockResponse = RestaurantListResponse(
      error: true,
      count: 0,
      message: "Gagal mendapatkan data",
      restaurants: [],
    );

    when(mockApiService.getRestaurantList())
        .thenAnswer((_) async => Future.value(mockResponse));

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListErrorState>());
  });
}
