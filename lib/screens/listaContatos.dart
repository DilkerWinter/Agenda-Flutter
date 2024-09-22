import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/screens/cadastroContatos.dart';
import 'package:agenda_flutter/widget/contatoCard.dart';
import 'package:flutter/material.dart';

class Listacontatos extends StatefulWidget {
  @override
  _ListacontatosState createState() => _ListacontatosState();
}

class _ListacontatosState extends State<Listacontatos> {
  List<Contato> contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    List<Contato> loadedContatos = await Contato.carregarContatos();
    setState(() {
      contatos = loadedContatos;
    });
  }

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
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return ContatoCard(
            nome: contato.nome,
            telefone: contato.telefone,
            email: contato.email,
          );
        },
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastrocontatos()),
            ).then((_) {
              _carregarContatos(); 
            });
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
