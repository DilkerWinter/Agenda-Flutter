import 'package:agenda_flutter/controller/UsuarioController.dart';
import 'package:agenda_flutter/model/Usuario.dart';
import 'package:agenda_flutter/screens/Usuario/login.dart';
import 'package:agenda_flutter/utils/validarUsuario.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usuarioTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();
  final TextEditingController senhaConfirmadaTextController = TextEditingController();
  final UsuarioController usuarioController = UsuarioController();

  @override
  void dispose() {
    usuarioTextController.dispose();
    senhaTextController.dispose();
    senhaConfirmadaTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 150,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Cadastro",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            const SizedBox(height: 20),
            TextField(
              controller: senhaConfirmadaTextController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async { // Fixed typo from `oonPressed` to `onPressed`
                String resultadoValidarCampos = validaCamposCadastro(
                  usuarioTextController.text,
                  senhaTextController.text,
                  senhaConfirmadaTextController.text,
                );

                if (resultadoValidarCampos != 'ok') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(resultadoValidarCampos)),
                  );
                } else if (senhaTextController.text != senhaConfirmadaTextController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('As senhas não coincidem.')),
                  );
                } else {
                  Usuario? usuarioExistente = await usuarioController.buscaUsuarioPorNome(usuarioTextController.text);

                  if (usuarioExistente != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Usuário já existe.')),
                    );
                  } else {

                    Usuario usuario = Usuario(nome: usuarioTextController.text, senha: senhaTextController.text);


                    usuarioController.adicionarUsuario(usuario);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Usuário registrado com sucesso!')),
                    );
                    Navigator.pop(context); 
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                "Registrar",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Já possui uma conta? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Faça login",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context); 
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
