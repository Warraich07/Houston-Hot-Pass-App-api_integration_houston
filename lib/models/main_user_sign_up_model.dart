class MainUserSignUpModel {
  int id;
  String name;
  String email;
  dynamic image;
  dynamic age;
  dynamic gender;
  dynamic avgSpending;
  dynamic offenDineOut;
  dynamic userAim;
  dynamic subscriptionPlan;
  bool subscriptionStatus;
  dynamic subscriptionExpiredAt;
  bool isVerified;
  bool hasProfileAdded;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  MainUserSignUpModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.age,
    required this.gender,
    required this.avgSpending,
    required this.offenDineOut,
    required this.userAim,
    required this.subscriptionPlan,
    required this.subscriptionStatus,
    required this.subscriptionExpiredAt,
    required this.isVerified,
    required this.hasProfileAdded,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MainUserSignUpModel.fromJson(Map<String, dynamic> json) => MainUserSignUpModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    age: json["age"],
    gender: json["gender"],
    avgSpending: json["avg_spending"],
    offenDineOut: json["offen_dine_out"],
    userAim: json["user_aim"],
    subscriptionPlan: json["subscription_plan"],
    subscriptionStatus: json["subscription_status"],
    subscriptionExpiredAt: json["subscription_expired_at"],
    isVerified: json["is_verified"],
    hasProfileAdded: json["has_profile_added"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "age": age,
    "gender": gender,
    "avg_spending": avgSpending,
    "offen_dine_out": offenDineOut,
    "user_aim": userAim,
    "subscription_plan": subscriptionPlan,
    "subscription_status": subscriptionStatus,
    "subscription_expired_at": subscriptionExpiredAt,
    "is_verified": isVerified,
    "has_profile_added": hasProfileAdded,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
