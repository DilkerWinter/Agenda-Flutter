import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/utils/validarInformacoes.dart';
import 'package:flutter/material.dart';

class Cadastrocontatos extends StatelessWidget {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os textos à esquerda
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Cadastro de Contato",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Nome",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _controllerNome,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Email",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Telefone",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _controllerTelefone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              // Centraliza o botão
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(30, 50)),
                  onPressed: () async {
                    String nome = _controllerNome.text;
                    String email = _controllerEmail.text;
                    String telefone = _controllerTelefone.text;

                    if (!validaInformacoes(nome, email, telefone)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Por favor, preencha todos os campos corretamente.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Contato contato = Contato(nome: nome, telefone: telefone, email: email);
                      Contato.adicionarContato(contato);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Contato adicionado com sucesso!'),
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
