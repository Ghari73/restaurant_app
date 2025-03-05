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
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      rating: (json["rating"] as num).toDouble(),
      pictureId:
          "https://restaurant-api.dicoding.dev/images/medium/${json["pictureId"]}",
      address: json["address"],
      categories: (json["categories"] as List)
          .map((item) => Categories.fromJson(item))
          .toList(),
      menus: Menus.fromJson(json["menus"]),
      customerReviews: (json["customerReviews"] as List)
          .map((item) => CustomerReviews.fromJson(item))
          .toList(),
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
      foods:
          (json["foods"] as List).map((item) => Foods.fromJson(item)).toList(),
      drinks: (json["drinks"] as List)
          .map((item) => Drinks.fromJson(item))
          .toList(),
    );
  }
}

class Categories {
  final String name;

  Categories({required this.name});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(name: json['name']);
  }
}

class Foods {
  final String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name']);
  }
}

class Drinks {
  final String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(name: json['name']);
  }
}

class CustomerReviews {
  final String name;
  final String review;
  final String date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json) {
    return CustomerReviews(
        name: json['name'], review: json['review'], date: json['date']);
  }
}

List<RestaurantDetail> bookmarkRestaurantList = [];
