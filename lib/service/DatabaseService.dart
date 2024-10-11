import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;

  static final DatabaseService instance = DatabaseService._constructor();

  final String _contatoTableName = "contato";
  final String _contatoIdColumnName = "id";
  final String _contatoNomeColumnName = 'nome';
  final String _contatoTelefoneColumnName = 'telefone';
  final String _contatoEmailColumnName = "email";

  String get contatoTableName => _contatoTableName;
  String get contatoIdColumnName => _contatoIdColumnName;
  String get contatoNomeColumnName => _contatoNomeColumnName;
  String get contatoTelefoneColumnName => _contatoTelefoneColumnName;
  String get contatoEmailColumnName => _contatoEmailColumnName;

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "agendaDB.db");
    return await openDatabase(
      databasePath,
      version: 1,  
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_contatoTableName (
            $_contatoIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_contatoNomeColumnName TEXT NOT NULL,
            $_contatoTelefoneColumnName TEXT NOT NULL,
            $_contatoEmailColumnName TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
      },
    );
  }
}
