import 'package:keepit/data/model/card_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImplLocalDataSource {
  ImplLocalDataSource._();

  static final ImplLocalDataSource instance = ImplLocalDataSource._();
  static Database? _db;
  final String _tabeName = 'Cards';
  final String _tableIdField = 'id';
  final String _tableNameField = 'name';
  final String _tableValueField = 'value';
  final String _tableDescriptionField = 'description';

  Future<Database> _init() async {
    if (_db != null) {
      return _db!;
    }
    _db = await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    try {
      final String dbPath = join(await getDatabasesPath(), 'keepit_db.db');
      Database db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          return db.execute(
            '''

        CREATE TABLE $_tabeName(
        $_tableIdField INTEGER PRIMARY KEY AUTOINCREMENT,
        $_tableNameField TEXT NOT NULL,
        $_tableValueField TEXT NOT NULL,
        $_tableDescriptionField TEXT
        )
        ''',
          );
        },
      );
      return db;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(
        'An error occurred during local database initialization.',
      );
    }
  }

  Future<List<CardEntity>> getAll() async {
    try {
      final db = await instance._init();
      final query = await db.query(_tabeName);
      final cards = query
          .map(
            (card) => CardEntity.fromJson(card),
          )
          .toList();
      print('Cards feached');
      return cards;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(
        'An error occurred during quering data from $_tabeName table.',
      );
    }
  }

  Future<void> add(CardEntity card) async {
    try {
      final db = await instance._init();

      final int result = await db.insert(
        _tabeName,
        card.toJson()..remove('id'),
      );
      if (result > 0) {
        print('Card added');
      } else {
        print('Error occured during adding into Cards');
      }
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(
        'An error occurred during inserting data into $_tabeName table.',
      );
    }
  }

  Future<void> edit(CardEntity card) async {
    try {
      final db = await instance._init();
      print(card.toString());
      db.update(
        _tabeName,
        card.toJson(),
        where: 'id = ?',
        whereArgs: [card.id],
      );
      print('Card edited');
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(
        'An error occurred during updating card id: $card, from $_tabeName table.',
      );
    }
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance._init();
      db.delete(
        _tabeName,
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Card deleted');
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(
        'An error occurred during deleting card id: $id, from $_tabeName table.',
      );
    }
  }
}
