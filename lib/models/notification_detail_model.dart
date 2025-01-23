// class Location {
//   int id;
//   String title;
//   double latitude;
//   double longitude;
//
//   Location({
//     required this.id,
//     required this.title,
//     required this.latitude,
//     required this.longitude,
//   });
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//     id: json["id"],
//     title: json["title"],
//     latitude: double.parse(json["latitude"]),
//     longitude: double.parse(json["longitude"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "latitude": latitude.toString(),
//     "longitude": longitude.toString(),
//   };
// }
//
// class Restaurant {
//   int id;
//   String name;
//   String email;
//   String image;
//   Location location;
//
//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.image,
//     required this.location,
//   });
//
//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     image: json["image"],
//     location: Location.fromJson(json["location"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "image": image,
//     "location": location.toJson(),
//   };
// }
//
// class NotificationData {
//   int id;
//   String title;
//   String description;
//   String image;
//   List<String> tags;
//   String termsConditions;
//   bool oneTime;
//   bool unlimited;
//   DateTime expirationDate;
//   bool isExpired;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Restaurant restaurant;
//
//   NotificationData({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.tags,
//     required this.termsConditions,
//     required this.oneTime,
//     required this.unlimited,
//     required this.expirationDate,
//     required this.isExpired,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.restaurant,
//   });
//
//   factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     image: json["image"],
//     tags: List<String>.from(json["tags"].map((x) => x)),
//     termsConditions: json["terms_conditions"],
//     oneTime: json["one_time"],
//     unlimited: json["unlimited"],
//     expirationDate: DateTime.parse(json["expiration_date"]),
//     isExpired: json["is_expired"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     restaurant: Restaurant.fromJson(json["restaurant"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "image": image,
//     "tags": tags,
//     "terms_conditions": termsConditions,
//     "one_time": oneTime,
//     "unlimited": unlimited,
//     "expiration_date": expirationDate.toIso8601String(),
//     "is_expired": isExpired,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "restaurant": restaurant.toJson(),
//   };
// }
