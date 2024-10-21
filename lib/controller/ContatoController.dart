import 'package:agenda_flutter/utils/nomeUsuarioSharedPrefs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/service/DatabaseService.dart';

class ContatoController {
  final DatabaseService _dbService = DatabaseService.instance;
  
  Future<int> adicionarContato(Contato contato) async{
    final db = await _dbService.database;
    return await db.insert(_dbService.contatoTableName, contato.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);   
  }

  Future<int> removerContato(int? id) async{
    final db = await _dbService.database;
    return await db.delete(
      _dbService.contatoTableName,
      where: '${_dbService.contatoIdColumnName} = ?',
      whereArgs: [id],
    );
  }

  Future<int> atualizarContato(Contato contato) async{
    final db = await _dbService.database;
    return await db.update(_dbService.contatoTableName, contato.toMap(),
    where: '${_dbService.contatoIdColumnName} = ?',
    whereArgs: [contato.id]
    );
  }

  Future<List<Contato>> getContatoOrdemAlfabetica() async {
    final db = await _dbService.database;
    final int usuarioId = await recuperandoIdUsuario();

    final List<Map<String, dynamic>> maps = await db.query(
      _dbService.contatoTableName,
      orderBy: _dbService.contatoNomeColumnName, 
      where: '${_dbService.contatoUsuarioIdColumnName} = ?',
      whereArgs: [usuarioId]
    );

    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
}

}
