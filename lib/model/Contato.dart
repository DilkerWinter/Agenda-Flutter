class Contato {
  int? id;
  String _nome;
  String _telefone;
  String _email;
  int _usuarioId;

  Contato({
    this.id,
    required String nome,
    required String telefone,
    required String email,
    required int usuarioId, 
  })  : _nome = nome,
        _telefone = telefone,
        _email = email,
        _usuarioId = usuarioId; 

  String get nome => _nome;
  String get telefone => _telefone;
  String get email => _email;
  int get usuarioId => _usuarioId; 

  set nome(String value) {
    _nome = value;
  }

  set telefone(String value) {
    _telefone = value;
  }

  set email(String value) {
    _email = value;
  }

  set usuarioId(int value) {
    _usuarioId = value; 
  }

  @override
  String toString() => 'nome: $_nome, telefone: $_telefone, email: $_email, usuarioId: $_usuarioId';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': _nome,
      'telefone': _telefone,
      'email': _email,
      'usuarioId': _usuarioId, 
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      usuarioId: map['usuarioId'] as int,
    );
  }
}
