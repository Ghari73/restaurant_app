class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.city,
      required this.rating,
      required this.pictureId}); 

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      rating: (json["rating"] as num).toDouble(),
      pictureId:
          "https://restaurant-api.dicoding.dev/images/small/${json["pictureId"]}",
    );
  }

  Map<String, dynamic> toJson() {
   return <String, dynamic>{
     "id": id,
     "name": name,
     "description": description,
     "city" : city,
     "rating" : rating,
     "pictureId" : pictureId
   };
 }
}

List<Restaurant> bookmarkRestaurantList = [];
