import 'package:agenda_flutter/model/Usuario.dart';
import 'package:agenda_flutter/service/DatabaseService.dart';
import 'package:agenda_flutter/utils/encryptarSenhas.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioController {
  final DatabaseService _dbService = DatabaseService.instance;


  Future<int> adicionarUsuario(Usuario usuario) async{
    final db = await _dbService.database;
    final encryptarsenhas = Encryptarsenhas();
    final senhaHash = encryptarsenhas.generateSHA256Hash(usuario.senha);

    final usuarioComHash = Usuario(
      id: usuario.id,
      nome: usuario.nome,
      senha: senhaHash, 
    );

    return await db.insert(_dbService.usuarioTableName, usuarioComHash.toMap(), conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<Usuario?> buscaUsuarioPorNome(String nome) async{
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _dbService.usuarioTableName,
      where: '${_dbService.usuarioNomeColumnName} = ?',
      whereArgs: [nome],
    );

    if(maps.isNotEmpty){
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

//Use somente para debuggar
Future<List<Usuario>> buscaTodosUsuarios() async {
  try {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query(_dbService.usuarioTableName);

    
    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

}