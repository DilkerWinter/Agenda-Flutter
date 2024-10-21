import 'package:agenda_flutter/controller/UsuarioController.dart';
import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/model/Usuario.dart';
import 'package:agenda_flutter/screens/Contato/listaContatos.dart';
import 'package:agenda_flutter/screens/Usuario/login.dart';
import 'package:agenda_flutter/service/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(Agenda());
}


class Agenda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(future: _isUsuarioLogado(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == true) {
              return Listacontatos(); 
            } else {
              return Login(); 
            }
          }
        },
      ),
    );
  }

  Future<bool> _isUsuarioLogado() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nomeSalvo = prefs.getString('nomeUsuario');
    return nomeSalvo != null  && nomeSalvo.isNotEmpty;
  }
}

