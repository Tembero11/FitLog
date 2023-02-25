import 'package:gym_diary/utils/question.dart';

abstract class QuestionManager {
  static List<Question> questions = [
    Question(
        question: "Did you take preworkout?",
        jsonKey: "pwo",
        questionType: QuestionType.string)
  ];

  static Question get(String questionKey) {
    return questions.firstWhere((q) => q.jsonKey == questionKey);
  }
}
