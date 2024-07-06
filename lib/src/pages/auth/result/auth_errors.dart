String authErrorsString(String? error) {
  switch (error) {
    case 'INVALID_CREDENTIALS':
      return 'Email ou Senha invalidos';

    case 'Invalid session token':
      return 'Token invalido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuario: Nome invalido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuario: Telefone invalido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuario: CPF invalido';

    default:
      return 'Um erro indefinido ocorreu';
  }
}
