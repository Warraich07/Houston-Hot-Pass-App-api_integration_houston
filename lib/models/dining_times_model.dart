class DiningTimesModel {
  int id;
  String title;
  String from;
  String to;

  DiningTimesModel({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
  });

  factory DiningTimesModel.fromJson(Map<String, dynamic> json) => DiningTimesModel(
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
