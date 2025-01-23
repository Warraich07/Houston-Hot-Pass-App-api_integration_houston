class CuisinesModel {
  int id;
  String title;

  CuisinesModel({
    required this.id,
    required this.title,
  });

  factory CuisinesModel.fromJson(Map<String, dynamic> json) => CuisinesModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
