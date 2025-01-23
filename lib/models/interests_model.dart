class InterestsModel {
  int id;
  String title;

  InterestsModel({
    required this.id,
    required this.title,
  });

  factory InterestsModel.fromJson(Map<String, dynamic> json) => InterestsModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
