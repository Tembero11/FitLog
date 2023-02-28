import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MonthFile {
  late final int version;
  late final DateTime date;
  // The keys are stringified integer days
  late Map<String, Object> _days;

  static const dirname = "data/months";
  static const currentVersion = 1;

  MonthFile.fromJson(Map<String, Object> json) {
    version = json["version"] as int;
    date = DateTime.parse(json["date"] as String);

    _days = json["data"] as Map<String, Object>;
  }

  MonthFile.empty(this.date) : version = currentVersion, _days = <String, Object>{};

  List<Workout>? getDay(int day) {
    String dayKey = day.toString();
    if (!_days.containsKey(dayKey)) return null;

    var rawWorkouts = _days[dayKey] as List<Map<String, Object>>;

    return rawWorkouts.map((workout) => Workout.fromJson(
      workout,
      DateUtils.addDaysToDate(date, day),
    )).toList();
  }

  toJson() {

  }

  static Future<Directory> _getDir() async {
    var documentDir = await getApplicationDocumentsDirectory();
    var path = '${documentDir.path}/$dirname';
    return Directory(path);
  }

  static Future<File> _getFile(String fileName) async {
    var dir = await _getDir();
    return File('${dir.path}/$fileName');
  }

  static createDir() async {
    var directory = await _getDir();

    if (!(await directory.exists())) {
      directory.create(recursive: true);
    }
  }

  static Future<bool> fileExists(String fileName) async {
    var file = await _getFile(fileName);
    return await file.exists();
  }

  static Future<Map<String, Object>> readFile(String fileName) async {
    var file = await _getFile(fileName);
    var data = await file.readAsString();

    return jsonDecode(data);
  }
}


class Workout {
  Map<String, Object> _raw;
  DateTime date;
  Workout.fromJson(this._raw, this.date);
}