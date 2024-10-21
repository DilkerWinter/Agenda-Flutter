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

  final String _usuarioTableName = "usuario";
  final String _usuarioIdColumnName = "id";
  final String _usuarioNomeColumnName = "nome";
  final String _usuarioSenhaColumnName = "senha";

  final String _contatoUsuarioIdColumnName = "usuarioId";

  String get contatoTableName => _contatoTableName;
  String get contatoIdColumnName => _contatoIdColumnName;
  String get contatoNomeColumnName => _contatoNomeColumnName;
  String get contatoTelefoneColumnName => _contatoTelefoneColumnName;
  String get contatoEmailColumnName => _contatoEmailColumnName;
  String get usuarioTableName => _usuarioTableName;
  String get usuarioIdColumnName => _usuarioIdColumnName;
  String get usuarioNomeColumnName => _usuarioNomeColumnName;
  String get usuarioSenhaColumnName => _usuarioSenhaColumnName;
  String get contatoUsuarioIdColumnName => _contatoUsuarioIdColumnName;

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
      version: 5,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_usuarioTableName (
            $_usuarioIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_usuarioNomeColumnName TEXT NOT NULL,
            $_usuarioSenhaColumnName TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $_contatoTableName (
            $_contatoIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_contatoNomeColumnName TEXT NOT NULL,
            $_contatoTelefoneColumnName TEXT NOT NULL,
            $_contatoEmailColumnName TEXT NOT NULL,
            $_contatoUsuarioIdColumnName INTEGER NOT NULL,
            FOREIGN KEY ($_contatoUsuarioIdColumnName) REFERENCES $_usuarioTableName($_usuarioIdColumnName)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print("Atualizando do version $oldVersion para $newVersion");
        if (oldVersion < 5) {
          db.execute('''
          CREATE TABLE usuario (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT,
            senha TEXT
          )
        ''');

          db.execute('DROP TABLE IF EXISTS contato');

          db.execute('''
      CREATE TABLE contato (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        telefone TEXT NOT NULL,
        email TEXT NOT NULL,
        usuarioId INTEGER NOT NULL,
        FOREIGN KEY (usuarioId) REFERENCES usuario(id)
      )
    ''');
        }
      },
    );
  }
}
