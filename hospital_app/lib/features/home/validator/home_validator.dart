class HomeValidator {
  HomeValidator._init();

  static HomeValidator instance = HomeValidator._init();

  String? polyclinicValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Poliklinik Seçiniz!";
    } else {
      return null;
    }
  }

  String? questionValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "Lütfen Bir Soru Giriniz!";
    } else {
      return null;
    }
  }
}
