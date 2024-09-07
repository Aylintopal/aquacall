import 'dart:async';
import 'package:aquacall/data/models/app_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();

  static Database? _db;

  static final DateTime _dateTime = DateTime.now();
  static final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  static const String _tableName = 'reminder_table';

  DatabaseService._internal();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'reminder_db.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return database;
  }

  void _onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY,
      age INTEGER,
      weight REAL,
      height REAL,
      dailyGoal INTEGER,
      amount INTEGER,
      dateTime TEXT
    )
    ''');
  }

  Future<void> insertUser(int age, double height, double weight) async {
    final int dailyGoal = calculateDailyWaterIntake(age, height, weight);
    final db = await database;
    final String formattedDate = _formatter.format(_dateTime);
    await db.insert(
      _tableName,
      {
        'age': age,
        'height': height,
        'weight': weight,
        'amount': 0,
        'dailyGoal': dailyGoal,
        'dateTime': formattedDate,
      },
    );
  }

  Future<int> updateAmount(AppModel model, int amount) async {
    final db = await database;
    final total = model.amount! + amount;
    return db.update(
      _tableName,
      {'amount': total},
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> deleteAmount(AppModel model) async {
    final db = await database;
    return await db.update(
      _tableName,
      {'amount': 0, 'dailyGoal': 0},
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future updateUser(
      AppModel model, int age, double height, double weight) async {
    final db = await database;
    final dailyGoal = calculateDailyWaterIntake(age, height, weight);
    return await db.update(
      _tableName,
      {
        'age': age,
        'height': height,
        'weight': weight,
        'dailyGoal': dailyGoal,
      },
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<List<AppModel>> getData() async {
    final db = await database;
    final data = await db.query(_tableName);
    List<AppModel> dataList = data.map((e) => AppModel.fromJson(e)).toList();
    return dataList;
  }

  int calculateDailyWaterIntake(int age, double height, double weight) {
    double waterIntakePerCm = 0.5;
    double waterIntakePerKg;

    if (age < 30) {
      waterIntakePerKg = 40;
    } else if (age < 55) {
      waterIntakePerKg = 35;
    } else {
      waterIntakePerKg = 30;
    }

    double totalWaterIntake =
        (weight * waterIntakePerKg) + (height * waterIntakePerCm);

    return totalWaterIntake.round();
  }
}
