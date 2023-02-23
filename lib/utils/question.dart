import 'dart:convert';

enum QuestionType {
  text,
  multipleChoice,
}

class Question {
  final String question;
  final String jsonKey;
  final QuestionType questionType;
  Question(
      {required this.question,
      required this.jsonKey,
      required this.questionType});

  @override
  String toString() {
    return jsonEncode({question, jsonKey, questionType});
  }
}
