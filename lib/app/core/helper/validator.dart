class Validator {
  Validator._();
  static const String _emailRegExpString =
      r'^[a-zA-Z0-9+._%+-]{1,256}@[a-zA-Z0-9-]{0,64}(\.[a-zA-Z0-9-]{2,25})+$';
  static final _emailRegex = RegExp(_emailRegExpString, caseSensitive: false);
  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidLowerCase(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  static bool isValidUpperCase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  static bool isValidPasswordNumber(String password) {
    return password.contains(RegExp(r'\d'));
  }

  static bool isValidLengthPassWord(String password) {
    return password.length > 7;
  }

  static bool isValidSymbol(String password) {
    RegExp symbolRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-=+]');
    return symbolRegex.hasMatch(password);
  }

  static bool isValidPassword(String password) {
    return isValidLowerCase(password) &&
        isValidUpperCase(password) &&
        isValidPasswordNumber(password) &&
        isValidLengthPassWord(password) &&
        isValidSymbol(password);
  }
}
