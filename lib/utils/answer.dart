abstract class Answer {
  String key;
  dynamic value;
  Answer({required this.key, required value});
}

class IntegerAnswer extends Answer {
  late int min;
  late int max;
  IntegerAnswer(
      {required super.key, required super.value, required min, required max});

  bool inRange() {
    return value >= min && value <= max;
  }
}
