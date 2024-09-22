import 'package:calendario/model/contatos.dart';
import 'package:flutter/material.dart';

void main() {
  Contatos contatos = Contatos(
    nome: 'Bruno',
    telefone: '679999',
    email: 'bruno@email.com',
  );

  runApp(Cadastro(contatos: contatos));
}

class Cadastro extends StatelessWidget {
  final Contatos contatos;

  Cadastro({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(contatos: contatos),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Contatos contatos;

  MyHomePage({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda Telefonica"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Text(
          contatos.toString(),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NovaTela()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class NovaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Contato"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Text(
          "Tela para adicionar um novo contato",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
