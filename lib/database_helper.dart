import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'animal.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'animal_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE animal_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            especie TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertAnimal(Animal animal) async {
    final db = await database;
    return await db.insert('animal_table', animal.toMap());
  }

  Future<List<Animal>> getAnimals() async {
    final db = await database;
    final maps = await db.query('animal_table');
    return List.generate(maps.length, (i) => Animal.fromMap(maps[i]));
  }

  Future<int> updateAnimal(Animal animal) async {
    final db = await database;
    return await db.update(
      'animal_table',
      animal.toMap(),
      where: 'id = ?',
      whereArgs: [animal.id],
    );
  }

  Future<int> deleteAnimal(int id) async {
    final db = await database;
    return await db.delete(
      'animal_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
