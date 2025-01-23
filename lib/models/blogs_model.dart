class BlogsModel {
  int id;
  Offer? offer;
  Restuarant restuarant;
  String title;
  String description;
  List<String> images;
  bool isFeatured;
  DateTime createdAt;
  DateTime updatedAt;

  BlogsModel({
    required this.id,
    required this.offer,
    required this.restuarant,
    required this.title,
    required this.description,
    required this.images,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
    id: json["id"],
    offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
    restuarant: Restuarant.fromJson(json["restuarant"]),
    title: json["title"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    isFeatured: json["is_featured"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer": offer?.toJson(),
    "restuarant": restuarant.toJson(),
    "title": title,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "is_featured": isFeatured,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Offer {
  int id;
  String title;
  String description;
  String image;
  List<String> tags;
  bool oneTime;
  bool unlimited;
  DateTime expirationDate;
  bool isExpired;
  DateTime createdAt;
  DateTime updatedAt;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    required this.oneTime,
    required this.unlimited,
    required this.expirationDate,
    required this.isExpired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    oneTime: json["one_time"],
    unlimited: json["unlimited"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    isExpired: json["is_expired"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "one_time": oneTime,
    "unlimited": unlimited,
    "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
    "is_expired": isExpired,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Restuarant {
  int id;
  String name;
  String email;
  String image;
  Location location;

  Restuarant({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.location,
  });

  factory Restuarant.fromJson(Map<String, dynamic> json) => Restuarant(
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

// class BlogsModel {
//   int id;
//   Offer offer;
//   Restuarant restuarant;
//   String title;
//   String description;
//   List<String> images;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   BlogsModel({
//     required this.id,
//     required this.offer,
//     required this.restuarant,
//     required this.title,
//     required this.description,
//     required this.images,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
//     id: json["id"],
//     offer: Offer.fromJson(json["offer"]),
//     restuarant: Restuarant.fromJson(json["restuarant"]),
//     title: json["title"],
//     description: json["description"],
//     images: List<String>.from(json["images"].map((x) => x)),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "offer": offer.toJson(),
//     "restuarant": restuarant.toJson(),
//     "title": title,
//     "description": description,
//     "images": List<dynamic>.from(images.map((x) => x)),
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Offer {
//   int id;
//   String title;
//   String description;
//   String image;
//   List<String> tags;
//   bool oneTime;
//   bool unlimited;
//   DateTime expirationDate;
//   bool isExpired;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   Offer({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.tags,
//     required this.oneTime,
//     required this.unlimited,
//     required this.expirationDate,
//     required this.isExpired,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Offer.fromJson(Map<String, dynamic> json) => Offer(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     image: json["image"],
//     tags: List<String>.from(json["tags"].map((x) => x)),
//     oneTime: json["one_time"],
//     unlimited: json["unlimited"],
//     expirationDate: DateTime.parse(json["expiration_date"]),
//     isExpired: json["is_expired"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "image": image,
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "one_time": oneTime,
//     "unlimited": unlimited,
//     "expiration_date": "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
//     "is_expired": isExpired,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
//
// class Restuarant {
//   int id;
//   String name;
//   String email;
//   String image;
//   Location location;
//
//   Restuarant({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.image,
//     required this.location,
//   });
//
//   factory Restuarant.fromJson(Map<String, dynamic> json) => Restuarant(
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
// class Location {
//   int id;
//   String title;
//   String latitude;
//   String longitude;
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
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "latitude": latitude,
//     "longitude": longitude,
//   };
// }
