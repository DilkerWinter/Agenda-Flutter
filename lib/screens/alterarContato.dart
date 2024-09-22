import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/utils/validarInformacoes.dart';
import 'package:flutter/material.dart';

class AlterarContato extends StatelessWidget {
  final String nome;
  final String email;
  final String telefone;

  AlterarContato({required this.nome, required this.email, required this.telefone});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController(text: nome);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController telefoneController = TextEditingController(text: telefone);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.contacts, color: Colors.white),
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
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!validaInformacoes(nomeController.text, emailController.text, telefoneController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, preencha todos os campos corretamente.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  Contato contato = Contato(
                    nome: nomeController.text,
                    telefone: telefoneController.text,
                    email: emailController.text,
                  );
                  await Contato.alterarContato(nome, contato);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Contato atualizado com sucessoa!'),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

}