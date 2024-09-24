import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agenda_flutter/utils/captalizeStrings.dart';

class ContatoCard extends StatelessWidget {
  final String nome;
  final String telefone;
  final String email;
  final VoidCallback onTap;

  ContatoCard({
    required this.nome,
    required this.telefone,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 15, right: 0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey, size: 24),
                      SizedBox(width: 8),
                      Text(
                        nome.toCapitalize(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey, size: 24),
                    onPressed: onTap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone, color: Colors.grey, size: 16),
                  SizedBox(width: 8),
                  Text(
                    telefone,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, color: Colors.grey, size: 16),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: telefone));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Número copiado: $telefone')),
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.grey, size: 16),
                  SizedBox(width: 8),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
