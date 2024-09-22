import 'package:flutter/material.dart';

bool validaInformacoes(String nome, String email, String telefone) {

  if(nome.isEmpty || email.isEmpty || telefone.isEmpty ||
    !validaEmail(email) || !validaTelefone(telefone)){
    return false;
  }

  return true;
}

bool validaEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

bool validaTelefone(String telefone) {
  final RegExp telefoneRegex = RegExp(
    r'^\(?\d{2}\)?[-.\s]?(\d{5}|\d{4})[-.\s]?\d{4}$',
  );
  return telefoneRegex.hasMatch(telefone);
}
