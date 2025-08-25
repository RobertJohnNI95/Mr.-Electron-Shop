bool isValidEmail(String email) {
  final bool emailValid = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  ).hasMatch(email);
  return emailValid;
}
