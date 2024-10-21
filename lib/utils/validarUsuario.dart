String validaCamposCadastro(String usuario, String senha, String senha2) {
  if (usuario.isEmpty || senha.isEmpty || senha2.isEmpty) {
    return 'Preencha todos os campos';
  }
  
  if (senha != senha2) {
    return 'As senhas são diferentes';
  }
  
  return 'ok';
}
