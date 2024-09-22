import 'dart:convert';

class Contatos {
  String _nome; 
  String _telefone;
  String _email;

  Contatos({
    required String nome,
    required String telefone,
    required String email,
  })  : _nome = nome,
        _telefone = telefone,
        _email = email;

  String get nome => _nome;
  String get telefone => _telefone;
  String get email => _email;

  set nome(String value) {
    _nome = value;
  }

  set telefone(String value) {
    _telefone = value;
  }

  set email(String value) {
    _email = value;
  }

  @override
  String toString() => 'nome: $_nome, telefone: $_telefone, email: $_email)';
}
