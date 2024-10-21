import 'package:agenda_flutter/controller/UsuarioController.dart';
import 'package:agenda_flutter/model/Usuario.dart';
import 'package:agenda_flutter/screens/Contato/listaContatos.dart';
import 'package:agenda_flutter/screens/Usuario/cadastro.dart';
import 'package:agenda_flutter/service/DatabaseService.dart';
import 'package:agenda_flutter/utils/encryptarSenhas.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usuarioTextController = TextEditingController();
    final TextEditingController senhaTextController = TextEditingController();
    final UsuarioController usuarioController = UsuarioController();
    final encryptarsenhas = Encryptarsenhas();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.account_circle_rounded, size: 150, color: Colors.lightBlue),
            const SizedBox(height: 20),
            const Center(
              child: Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usuarioTextController,
              decoration: InputDecoration(
                labelText: "Usuário",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: senhaTextController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final String usuario = usuarioTextController.text;
                final String senha = senhaTextController.text;

                if (usuario.isEmpty || senha.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor, preencha todos os campos.")),
                  );
                } else {
                  Usuario? usuarioEncontrado = await usuarioController.buscaUsuarioPorNome(usuario);
                  if (usuarioEncontrado == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuário não encontrado.")),
                    );
                    return;
                  }

                  if (usuarioEncontrado.nome == usuario && usuarioEncontrado.senha == encryptarsenhas.generateSHA256Hash(senha)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login bem-sucedido!")),
                    );
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('nomeUsuario', usuarioEncontrado.nome);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Listacontatos()), (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuário ou senha incorretos.")),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 15),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Não possui uma conta? ", style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: "Crie uma conta",
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Register()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
