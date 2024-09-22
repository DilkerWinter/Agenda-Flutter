import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/screens/cadastroContatos.dart';
import 'package:flutter/material.dart';

class Listacontatos extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.contacts, 
              color: Colors.white,
            ),
            SizedBox(width: 8.0), 
            Text("Disk Contatos"),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "teste",
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastrocontatos()),
            );
          },
          child: Icon(
            Icons.add_circle_outline_rounded,
            size: 40,
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
