import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataManager {
  static const filename = 'workouts.json';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('$dir/$filename');
  }

  hasData() async {
    final file = await _getFile();
    return await file.exists();
  }

  getData() async {
    final file = await _getFile();
    final content = await file.readAsString();
    return jsonDecode(content);
  }

  String createBaseData() {
    final date = DateTime.now();
    const version = 1;

    final data = {
      "version": version,
      "calendar": {date.year.toString(): {}}
    };

    return jsonEncode(data);
  }
}
