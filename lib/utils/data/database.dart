import 'package:gym_diary/utils/data/models/question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await open();
    return _database!;
  }

  Future<Database> open() async {
    return openDatabase(
      join(await getDatabasesPath(), 'main.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  _onCreate(Database db, int version) {
    return db.execute(
      'CREATE TABLE ${QuestionModel.getTableString()}',
    );
  }

  Future<void> insertQuestion(QuestionModel question) async {
    final db = await database;

    await db.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QuestionModel>> getQuestions() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('questions');

    return List.generate(maps.length, (i) => QuestionModel.fromMap(maps[i]));
  }


  Future<void> deleteQuestion(int id) async {
    final db = await database;

    await db.delete(
      'questions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateQuestion(QuestionModel question) async {
    final db = await database;

    await db.update(
      'questions',
      question.toMap(),
      where: 'id = ?',
      whereArgs: [question.id],
    );
  }

}