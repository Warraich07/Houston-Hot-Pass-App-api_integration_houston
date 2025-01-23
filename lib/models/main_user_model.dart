class MainUserLoginModel {
  int id;
  String name;
  String email;
  String image;
  Age age;
  String gender;
  Age avgSpending;
  String oftenDineOut;
  String userAim;
  dynamic subscriptionPlan;
  bool subscriptionStatus;
  dynamic subscriptionExpiredAt;
  bool isVerified;
  bool hasProfileAdded;
  bool status;
  List<Cuisine> cuisines;
  List<DiningTime> diningTimes;
  List<Cuisine> interests;
  IalLocation residentialLocation;
  IalLocation commercialLocation;
  NotificationSettings notificationSettings;
  String hasUnReadNotification;
  DateTime createdAt;
  DateTime updatedAt;

  MainUserLoginModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.age,
    required this.gender,
    required this.avgSpending,
    required this.oftenDineOut,
    required this.userAim,
    required this.subscriptionPlan,
    required this.subscriptionStatus,
    required this.subscriptionExpiredAt,
    required this.isVerified,
    required this.hasProfileAdded,
    required this.status,
    required this.cuisines,
    required this.diningTimes,
    required this.interests,
    required this.residentialLocation,
    required this.commercialLocation,
    required this.notificationSettings,
    required this.hasUnReadNotification,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainUserLoginModel.fromJson(Map<String, dynamic> json) => MainUserLoginModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"] ?? '',
    age: Age.fromJson(json["age"]),
    gender: json["gender"],
    avgSpending: Age.fromJson(json["avg_spending"]),
    oftenDineOut: json["often_dine_out"],
    userAim: json["user_aim"],
    subscriptionPlan: json["subscription_plan"],
    subscriptionStatus: json["subscription_status"],
    subscriptionExpiredAt: json["subscription_expired_at"],
    isVerified: json["is_verified"],
    hasProfileAdded: json["has_profile_added"],
    status: json["status"],
    cuisines: List<Cuisine>.from(json["cuisines"].map((x) => Cuisine.fromJson(x))),
    diningTimes: List<DiningTime>.from(json["dining_times"].map((x) => DiningTime.fromJson(x))),
    interests: List<Cuisine>.from(json["interests"].map((x) => Cuisine.fromJson(x))),
    residentialLocation: IalLocation.fromJson(json["residential_location"]),
    commercialLocation: IalLocation.fromJson(json["commercial_location"]),
    notificationSettings: NotificationSettings.fromJson(json["notification_settings"]),
    hasUnReadNotification: json["has_unread_notification"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "age": age.toJson(),
    "gender": gender,
    "avg_spending": avgSpending.toJson(),
    "often_dine_out": oftenDineOut,
    "user_aim": userAim,
    "subscription_plan": subscriptionPlan,
    "subscription_status": subscriptionStatus,
    "subscription_expired_at": subscriptionExpiredAt,
    "is_verified": isVerified,
    "has_profile_added": hasProfileAdded,
    "status": status,
    "cuisines": List<dynamic>.from(cuisines.map((x) => x.toJson())),
    "dining_times": List<dynamic>.from(diningTimes.map((x) => x.toJson())),
    "interests": List<dynamic>.from(interests.map((x) => x.toJson())),
    "residential_location": residentialLocation.toJson(),
    "commercial_location": commercialLocation.toJson(),
    "has_unread_notification": hasUnReadNotification,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Age {
  String from;
  String to;

  Age({
    required this.from,
    required this.to,
  });

  factory Age.fromJson(Map<String, dynamic> json) => Age(
    from: json["from"].toString(),
    to: json["to"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
  };
}

class IalLocation {
  int id;
  String title;
  String latitude;
  String longitude;
  String type;

  IalLocation({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  factory IalLocation.fromJson(Map<String, dynamic> json) => IalLocation(
    id: json["id"],
    title: json["title"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "latitude": latitude,
    "longitude": longitude,
    "type": type,
  };
}

class Cuisine {
  int id;
  String title;

  Cuisine({
    required this.id,
    required this.title,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class DiningTime {
  int id;
  String title;
  String from;
  String to;

  DiningTime({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
  });

  factory DiningTime.fromJson(Map<String, dynamic> json) => DiningTime(
    id: json["id"],
    title: json["title"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "from": from,
    "to": to,
  };
}

class NotificationSettings {
  bool newPerks;
  bool reminders;
  bool newsUpdates;

  NotificationSettings({
    required this.newPerks,
    required this.reminders,
    required this.newsUpdates,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => NotificationSettings(
    newPerks: json["new_perks"],
    reminders: json["reminders"],
    newsUpdates: json["news_updates"],
  );

  Map<String, dynamic> toJson() => {
    "new_perks": newPerks,
    "reminders": reminders,
    "news_updates": newsUpdates,
  };
}