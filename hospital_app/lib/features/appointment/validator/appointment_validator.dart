class AppointmentValidator {
  AppointmentValidator._init();

  static AppointmentValidator instance = AppointmentValidator._init();

  String? hospitalValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Hastane Seçiniz!";
    } else {
      return null;
    }
  }

  String? polyclinicValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Poliklinik Seçiniz!";
    } else {
      return null;
    }
  }

  String? doctorValidate(String? value) {
    if (value == null) {
      return "Lütfen Bir Doktor Seçiniz!";
    } else {
      return null;
    }
  }
}
