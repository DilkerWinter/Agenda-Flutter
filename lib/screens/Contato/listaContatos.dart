import 'package:agenda_flutter/controller/ContatoController.dart';
import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/screens/Contato/alterarContato.dart';
import 'package:agenda_flutter/screens/Contato/cadastroContatos.dart';
import 'package:agenda_flutter/screens/Usuario/login.dart';
import 'package:agenda_flutter/widget/contatoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Listacontatos extends StatefulWidget {
  @override
  _ListacontatosState createState() => _ListacontatosState();
}

class _ListacontatosState extends State<Listacontatos> {
  List<Contato> contatos = [];
  final contatoController = ContatoController();

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    List<Contato> loadedContatos =
        await contatoController.getContatoOrdemAlfabetica();
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
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              _showDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return ContatoCard(
            nome: contato.nome,
            telefone: contato.telefone,
            email: contato.email,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlterarContato(
                    antigoId: contato.id,
                    antigoNome: contato.nome,
                    antigoEmail: contato.email,
                    antigoTelefone: contato.telefone,
                  ),
                ),
              ).then((_) {
                _carregarContatos();
              });
            },
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

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmar Saída"),
        content: Text("Você realmente deseja deslogar da sua conta?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              FlutterSecureStorage secureStorage = FlutterSecureStorage();
              await secureStorage.delete(key: 'nomeUsuario');
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text("Sair"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
        ],
      );
    },
  );
}
