import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/screens/listaContatos.dart';
import 'package:flutter/material.dart';


void main(){
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
