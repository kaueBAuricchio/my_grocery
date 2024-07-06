import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email';
  }

  if (!email.isEmail) return 'Digite seu email';
  return null;
}

String? passValidator(String? pass) {
  if (pass == null || pass.isEmpty) {
    return 'Digite sua senha';
  }

  if (pass.length < 7) return 'Digite uma senha com pelos 7 digitos';
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }

  final names = name.split('');
  if (names.length == 1) return 'Digite seu nome completo';
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um numero valido!';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um cpf';
  }

  if (!cpf.isCpf) return 'Digite um cpf valido!';
  return null;
}
