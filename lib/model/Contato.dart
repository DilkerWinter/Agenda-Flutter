import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Contato {
  String _nome; 
  String _telefone;
  String _email;

  Contato({
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

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'telefone': _telefone,
      'email': _email,
    };
  }

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
    );
  }


  static Future<List<Contato>> carregarContatos() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    List<String>? contatosJson = prefs.getStringList('contatos');

    if (contatosJson != null) {
      return contatosJson.map((contatoJson) {
        return Contato.fromJson(jsonDecode(contatoJson));
      }).toList();
    } else {
      return [];
    }
  }

 static Future<void> adicionarContato(Contato novoContato) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    List<Contato> contatos = await carregarContatos();

    contatos.add(novoContato);

    contatos.sort((a, b) => a.nome.compareTo(b.nome));

    List<String> contatosJson = contatos.map((contato) {
      return jsonEncode(contato.toJson());
    }).toList();

    await prefs.setStringList('contatos', contatosJson);
  }
}