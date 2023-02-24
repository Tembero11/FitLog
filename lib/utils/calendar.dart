import 'dart:collection';

class Calendar {
  late SplayTreeMap years;
  Calendar({required Map data}) {
    years = SplayTreeMap.from(data["calendar"], (a, b) {
      return int.parse(a) - int.parse(b);
    });
  }

  getYear(int year) {
    if (!years.containsKey(year.toString())) return null;
  }
}

class Year {
  
}
