class FaqModel {
  String id;
  String question;
  String answer;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        answer: json['answer'],
        question: json['question'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'question': question,
        'id': id,
      };
}
