class RegisterValidator {
  RegisterValidator._init();

  static RegisterValidator instance = RegisterValidator._init();

  String? firstNameController(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "En Az 3 Karekter İçeren Bir Ad Girmelisiniz!";
    } else {
      return null;
    }
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 3) {
      return "En Az 3 Karekter İçeren Bir Soyad Girmelisiniz!";
    } else {
      return null;
    }
  }

  String? identityController(String? value) {
    if (value == null || value.isEmpty || value.length != 11) {
      return "TC Kimlik Numaranız 11 Haneli Olmalıdır!";
    } else {
      return null;
    }
  }

  String? birthDateController(String? value) {
    if (value == null || value.isEmpty) {
      return "Bir Doğum Tarihi Seçiniz!";
    } else {
      return null;
    }
  }

  String? bloodValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Kan Grubu Seçiniz!";
    } else {
      return null;
    }
  }

  String? genderValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Cinsiyet Seçiniz!";
    } else {
      return null;
    }
  }
}
