import 'dart:convert';

class Contato {
  int? id;
  String _nome;
  String _telefone;
  String _email;

  Contato({
    this.id,
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
  String toString() => 'nome: $_nome, telefone: $_telefone, email: $_email';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': _nome,
      'telefone': _telefone,
      'email': _email,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
    );
  }
}
