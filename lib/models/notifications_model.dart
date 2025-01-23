import 'dart:convert';

class NotificationsData {
  int id;
  String notificationType;
  String title;
  String body;
  NotificationData notificationData; // Change type to NotificationData
  String readAt;
  String createdAt;
  String updatedAt;

  NotificationsData({
    required this.id,
    required this.notificationType,
    required this.title,
    required this.body,
    required this.notificationData,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
    id: json["id"],
    notificationType: json["notification_type"],
    title: json["title"],
    body: json["body"],
    notificationData: NotificationData.fromJson(jsonDecode(json["notification_data"])),
    readAt: json["read_at"] ?? '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notification_type": notificationType,
    "title": title,
    "body": body,
    "notification_data": notificationData.toJson(),
    "read_at": readAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class NotificationData {
  int id;
  Restaurant restaurant;
  String title;
  String description;
  String image;
  List<String> tags;
  String termsConditions;
  bool oneTime;
  bool unlimited;
  String expirationDate;
  bool isExpired;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationData({
    required this.id,
    required this.restaurant,
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    required this.termsConditions,
    required this.oneTime,
    required this.unlimited,
    required this.expirationDate,
    required this.isExpired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    restaurant: Restaurant.fromJson(json["restuarant"]),
    title: json["title"],
    description: json["description"],
    image: json["image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    termsConditions: json["terms_conditions"],
    oneTime: json["one_time"],
    unlimited: json["unlimited"],
    expirationDate: json["expiration_date"],
    isExpired: json["is_expired"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restuarant": restaurant.toJson(),
    "title": title,
    "description": description,
    "image": image,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "terms_conditions": termsConditions,
    "one_time": oneTime,
    "unlimited": unlimited,
    "expiration_date": expirationDate,
    "is_expired": isExpired,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Restaurant {
  int id;
  String name;
  String email;
  String image;
  Location location;

  Restaurant({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.location,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "location": location.toJson(),
  };
}

class Location {
  int id;
  String title;
  String latitude;
  String longitude;

  Location({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    title: json["title"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "latitude": latitude,
    "longitude": longitude,
  };
}
