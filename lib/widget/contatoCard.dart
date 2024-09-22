import 'package:flutter/material.dart';

class ContatoCard extends StatelessWidget {
  final String nome;
  final String telefone;
  final String email;
  final VoidCallback onTap; // Adicione um callback para o clique

  ContatoCard({
    required this.nome,
    required this.telefone,
    required this.email,
    required this.onTap, // Inicialize o callback no construtor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Chama o callback quando o card é clicado
      child: Card(
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
      ),
    );
  }
}
