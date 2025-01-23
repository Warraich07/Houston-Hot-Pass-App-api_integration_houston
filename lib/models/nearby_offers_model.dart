class NearbyOffersModel {
  int id;
  Restuarant restuarant;
  String title;
  String description;
  String image;
  List<String> tags;
  String termsConditions;
  bool oneTime;
  bool unlimited;
  DateTime expirationDate;
  bool isExpired;
  DateTime createdAt;
  DateTime updatedAt;

  NearbyOffersModel({
    required this.id,
    required this.restuarant,
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

  factory NearbyOffersModel.fromJson(Map<String, dynamic> json) => NearbyOffersModel(
    id: json["id"],
    restuarant: Restuarant.fromJson(json["restuarant"]),
    title: json["title"],
    description: json["description"],
    image: json["image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    termsConditions: json["terms_conditions"],
    oneTime: json["one_time"],
    unlimited: json["unlimited"],
    expirationDate: DateTime.parse(json["expiration_date"]),
    isExpired: json["is_expired"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restuarant": restuarant.toJson(),
    "title": title,
    "description": description,
    "image": image,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "terms_conditions": termsConditions,
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
    name: json["name"]==null?'':json["name"],
    email: json["email"]==null?'':json["email"],
    image: json["image"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "email": emailValues.reverse[email],
    "image": image,
    "location": location.toJson(),
  };
}

enum Email {
  CHINAKITCHEN_GMAIL_COM,
  TAHA101_GMAIL_COM,
  TALHA101_GMAIL_COM
}

final emailValues = EnumValues({
  "Chinakitchen@gmail.com": Email.CHINAKITCHEN_GMAIL_COM,
  "taha101@gmail.com": Email.TAHA101_GMAIL_COM,
  "talha101@gmail.com": Email.TALHA101_GMAIL_COM
});

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
    title: json["title"]==null?'':json["title"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "latitude": latitude,
    "longitude": longitude,
  };
}

enum Title {
  BOULEVARD_MALL,
  FASIALABAD
}

final titleValues = EnumValues({
  "Boulevard Mall": Title.BOULEVARD_MALL,
  "Fasialabad": Title.FASIALABAD
});

enum Name {
  MUHAMMAD_USMAN,
  TAHA,
  TALHA
}

final nameValues = EnumValues({
  "Muhammad Usman": Name.MUHAMMAD_USMAN,
  "taha": Name.TAHA,
  "Talha": Name.TALHA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
