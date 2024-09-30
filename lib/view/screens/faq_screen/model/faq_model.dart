class FaqDatum {
  String? question;
  String? answer;
  DateTime? createdAt;

  FaqDatum({
    this.question,
    this.answer,
    this.createdAt,
  });

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
        question: json["question"],
        answer: json["answer"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "createdAt": createdAt?.toIso8601String(),
      };
}
