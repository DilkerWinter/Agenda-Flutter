import 'package:agenda_flutter/controller/UsuarioController.dart';
import 'package:agenda_flutter/model/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _getNomeUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('nomeUsuario'); 
}

Future<int> recuperandoIdUsuario() async {
  String? nomeUsuario = await _getNomeUsuario();
  
  if (nomeUsuario != null) {
    UsuarioController usuarioController = UsuarioController(); 
    Usuario? usuario = await usuarioController.buscaUsuarioPorNome(nomeUsuario); 
    if (usuario != null && usuario.id != null) {
      return usuario.id!; 
    } else {
      return 0; 
    }
  } else {
    return 0; 
  }
}
