class FaqsModel {
  int id;
  String question;
  String answer;

  FaqsModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqsModel.fromJson(Map<String, dynamic> json) => FaqsModel(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
  };
}
