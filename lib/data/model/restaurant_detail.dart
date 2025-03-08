class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final double rating;
  final List<Categories> categories;
  final Menus menus;
  final List<CustomerReviews> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.rating,
    required this.pictureId,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      city: json["city"] ?? '',
      rating: (json["rating"] ?? 0).toDouble(),
      pictureId: json["pictureId"] != null
          ? "https://restaurant-api.dicoding.dev/images/medium/${json["pictureId"]}"
          : '', // 🔥 Perbaikan: Hindari menempelkan `null` ke string
      address: json["address"] ?? '',
      categories: (json["categories"] as List?)
          ?.map((item) => Categories.fromJson(item))
          .toList() ?? [], // 🔥 Perbaikan: Handle null List
      menus: json["menus"] != null
          ? Menus.fromJson(json["menus"])
          : Menus(foods: [], drinks: []), // 🔥 Perbaikan: Hindari null
      customerReviews: (json["customerReviews"] as List?)
          ?.map((item) => CustomerReviews.fromJson(item))
          .toList() ?? [], // 🔥 Perbaikan: Handle null List
    );
  }
}

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json["foods"] as List?)
              ?.map((item) => Foods.fromJson(item))
              .toList() ??
          [], // 🔥 Perbaikan: Handle null List
      drinks: (json["drinks"] as List?)
              ?.map((item) => Drinks.fromJson(item))
              .toList() ??
          [], // 🔥 Perbaikan: Handle null List
    );
  }
}

class Categories {
  final String name;

  Categories({required this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(name: json['name'] ?? ''); // 🔥 Perbaikan: Handle null
  }
}

class Foods {
  final String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name'] ?? ''); // 🔥 Perbaikan: Handle null
  }
}

class Drinks {
  final String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(name: json['name'] ?? ''); // 🔥 Perbaikan: Handle null
  }
}

class CustomerReviews {
  final String name;
  final String review;
  final String date;

  CustomerReviews({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReviews.fromJson(Map<String, dynamic> json) {
    return CustomerReviews(
      name: json['name'] ?? '', // 🔥 Perbaikan: Handle null
      review: json['review'] ?? '', // 🔥 Perbaikan: Handle null
      date: json['date'] ?? '', // 🔥 Perbaikan: Handle null
    );
  }
}

List<RestaurantDetail> bookmarkRestaurantList = [];
