import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class MonthFile {
  static const dirname = "data/months"; 

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

  static Future<Map<String, Object>> readFile(String fileName) async {
    var file = await _getFile(fileName);
    var data = await file.readAsString();

    return jsonDecode(data);
  }

  MonthFile.fromJson();

  toJson() {

  }
}