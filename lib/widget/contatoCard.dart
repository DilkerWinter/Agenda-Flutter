import 'package:flutter/material.dart';

class ContatoCard extends StatelessWidget {
  final String nome;
  final String telefone;
  final String email;

  ContatoCard({required this.nome, required this.telefone, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(telefone),
            SizedBox(height: 4),
            Text(email),
          ],
        ),
      ),
    );
  }
}
