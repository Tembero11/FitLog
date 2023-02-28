import 'dart:io';

import 'package:path_provider/path_provider.dart';

class QuestionFile {
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
}