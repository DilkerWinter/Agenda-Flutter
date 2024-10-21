class Usuario {
  final int? _id;
  final String _nome;
  final String _senha;

  Usuario({
    int? id,
    required String nome,
    required String senha,
  })  : _id = id,
        _nome = nome,
        _senha = senha;

  int? get id => _id;
  String get nome => _nome;
  String get senha => _senha;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      senha: map['senha'],
    );
  }
}
