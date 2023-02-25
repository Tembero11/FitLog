import 'dart:collection';

abstract class Base<K, V> {
  HashMap<K, V> data;
  Base({required this.data});

  // ignore: unused_element
  _get(K key) {
    if (!data.containsKey(key)) return null;
    return data[key];
  }
}

class Calendar extends Base<String, Object> {
  Calendar({required super.data});

  getDate(int day, int month, int year) {
    final original = _get('$day.$month.$year');
    if (!original) return null;

    
  }
}
