class QuestionModel {
  final int id;
  final String question;
  final String? icon;

  static String getTableString() {
    return 'questions(id INTEGER PRIMARY KEY, question TEXT, icon TEXT)';
  }

  QuestionModel({ 
    required this.id,
    required this.question,
    this.icon
  });

  QuestionModel.fromMap(Map<String, dynamic> map) : id = map["id"], question = map["question"], icon = map["icon"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'icon': icon,
    };
  }

  @override
  String toString() {
    return 'Question{id: $id, question: $question, icon: $icon}';
  }
}