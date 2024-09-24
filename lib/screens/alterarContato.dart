import 'package:agenda_flutter/model/Contato.dart';
import 'package:agenda_flutter/utils/validarInformacoes.dart';
import 'package:flutter/material.dart';

class AlterarContato extends StatelessWidget {
  final String antigoNome;
  final String antigoEmail;
  final String antigoTelefone;

  AlterarContato({
    required this.antigoNome,
    required this.antigoEmail,
    required this.antigoTelefone,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController =
        TextEditingController(text: antigoNome);
    TextEditingController emailController =
        TextEditingController(text: antigoEmail);
    TextEditingController telefoneController =
        TextEditingController(text: antigoTelefone);

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
      body: SingleChildScrollView(  // Corrigido aqui
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Editar Contato',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                    labelText: 'Nome', labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email', labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(
                    labelText: 'Telefone', labelStyle: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmação'),
                            content: Text(
                                'Tem certeza de que deseja deletar este contato?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Contato.excluirContatoPorNome(antigoNome);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Contato deletado com sucesso!'),
                                  ));
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                },
                                child: Text('Deletar'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Deletar',
                    style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: Size(30, 50)),
                  ),
                  SizedBox(width: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      String novoNome = nomeController.text;
                      String novoEmail = emailController.text;
                      String novoTelefone = telefoneController.text;

                      //Verifica se o nome foi alterado para nao dar conflito
                      bool nomeJaExiste = await validaNome(novoNome);
                      bool alterouNome = novoNome != antigoNome;
                      bool informacoesValidas =
                          validaInformacoes(novoNome, novoEmail, novoTelefone);
                      if (!alterouNome) {
                        nomeJaExiste = false;
                      }

                      print(informacoesValidas);
                      if (!informacoesValidas || nomeJaExiste) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Informações inválidas ou já existentes.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmação'),
                              content: Text(
                                  'Tem certeza de que deseja salvar as alterações?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Contato contato = Contato(
                                        nome: novoNome,
                                        email: novoEmail,
                                        telefone: novoTelefone);
                                    Contato.alterarContato(antigoNome, contato);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Contato alterado com sucesso!'),
                                    ));
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Confirmar'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Salvar',
                    style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(30, 50)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
