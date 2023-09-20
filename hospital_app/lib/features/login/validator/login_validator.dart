class LoginValidator {
  LoginValidator._init();

  static LoginValidator instance = LoginValidator._init();

  String? emailController(String? value) {
    if (value == null || !value.contains("@") || !value.contains(".com")) {
      return "Lütfen Geçerli Bir Eposta Giriniz!";
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.length < 8) {
      return "Şifreniz En Az 8 Karekterli Olmalıdır!";
    } else {
      return null;
    }
  }

  String? personalPassValidator(String? value) {
    if (value == null || value.length < 6) {
      return "Şifreniz En Az 6 Karekterli Olmalıdır!";
    } else {
      return null;
    }
  }
}
