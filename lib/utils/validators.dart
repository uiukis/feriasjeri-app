String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'O e-mail é obrigatório';
  }
  if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
    return 'Por favor, insira um e-mail válido';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'A senha é obrigatória';
  }
  if (value.length < 6) {
    return 'A senha deve ter pelo menos 6 caracteres';
  }
  return null;
}

