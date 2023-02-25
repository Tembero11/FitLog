import 'package:gym_diary/utils/answer.dart';

enum QuestionType { number, string }

class Question {
  final String question;
  final String jsonKey;
  final QuestionType questionType;
  Question(
      {required this.question,
      required this.jsonKey,
      required this.questionType});

  isValid(Answer answer) {
    if (answer.key != jsonKey) return false;

    
  }
}
