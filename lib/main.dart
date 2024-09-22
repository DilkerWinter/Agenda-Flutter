import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/screens/listaContatos.dart';
import 'package:agenda_flutter/utils/clearSharedPreferences.dart';
import 'package:flutter/material.dart';

void main() {
  //Limpar a Memoria
  //WidgetsFlutterBinding.ensureInitialized();
  //clearSharedPreferences();
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
      home: Listacontatos(),
    );
  }
}
