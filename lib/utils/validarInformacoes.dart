import 'package:agenda_flutter/model/Contato.dart';
import 'package:flutter/material.dart';

//validador de campos
bool validaInformacoes(String nome, String email, String telefone) {
  if (nome.isEmpty ||
      email.isEmpty ||
      telefone.isEmpty ||
      !validaEmail(email) ||
      !validaTelefone(telefone)) {
    return false;
  }
  return true;
}

bool validaEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  bool emailValido = emailRegex.hasMatch(email);

  if (emailValido) {
    print("Email válido.");
  } else {
    print("Email inválido.");
  }

  return emailValido;
}

bool validaTelefone(String telefone) {
  final RegExp telefoneRegex = RegExp(
    r'^\(?\d{2}\)?[-.\s]?(\d{5}|\d{4})[-.\s]?\d{4}$',
  );
  bool telefoneValido = telefoneRegex.hasMatch(telefone);

  if (telefoneValido) {
    print("Telefone válido.");
  } else {
    print("Telefone inválido.");
  }

  return telefoneValido;
}

//verifica se o nome existe na memoria
Future<bool> validaNome(String nome) async {
  try {
    Contato? contato = await Contato.buscarContatoPorNome(nome);
    return true;
  } catch (e) {
    return false;
  }
}
