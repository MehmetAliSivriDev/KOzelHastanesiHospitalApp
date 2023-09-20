class ProductStrings {
  static ProductStrings? _instance;
  static ProductStrings get instance {
    _instance ??= ProductStrings._init();
    return _instance!;
  }

  ProductStrings._init();

  //Login Strings
  final String pLoginButtonText = "Personel Giriş";
  final String loginButtonText = "Giriş";
  final String registerButtonText = "Kayıt Ol";

  //Home Strings
  final String homeViewAppBarText = "Kırklareli Özel Hastanesi";

  final String uzmanSoruTitle = "Uzmanlarımıza Soru Sor";
  final String uzmanSoruSubtitle =
      "Uzman Hekim Kadromuzla Sorularınıza Yanıt Bulun.";

  final String randevuAlTitle = "Randevu Al";
  final String randevuAlSubtitle = "Hastanemizden Online Randevu Al.";

  final String pUpdateInfoBText = "Bilgileri Güncelle";

  final String pqViewHeaderText = "Uzmanlarımıza Soru Sorun";

  final String pqViewQuestionTFText = "Sorunuzu Giriniz";

  final String pmViewAppBarText = "Mesajlar";

  final String pmViewNoMessageText = "Mesaj Kutunuz Boş";

  final String upiViewAppBarText = "Hasta Bilgilerini Güncelle";

  final String upiViewInfoText =
      "İstediğimiz bu bilgileri size daha iyi bir hizmet sunmak için istiyoruz.";

  final String pmViewInfoCardText =
      "Şikayetleriniz hala devam ediyorsa lütfen en yakın hastanemize başvurup doktorlarımızdan yardım alınız.";

  //Appointment Strings
  final String hpViewAppBarText = "Hastane & Poliklinik Seçimi";

  final String hpViewContentExpText =
      "Randevu almak istediğiniz hastaneyi ve rahatsızlığınızın bulunduğu polikliniği seçerek size daha doğru bir hizmet vermemize yardımcı olun.";

  final String hpViewHospitalDHintText = "Lütfen Bir Hastane Seçiniz";

  final String hpViewPolycilinicDHintText = "Lütfen Bir Poliklinik Seçiniz";

  final String dViewAppBarText = "Doktor Seçimi";

  final String dViewContentExpText =
      "Hastanemizin sahip olduğu işinde tecrübeli ve kaliteli doktorlarımızdan randevu almak istediğinizi seçiniz.";

  final String dViewDoctorDHintText = "Lütfen Bir Doktor Seçiniz";

  final String appointmentContinueBText = "Devam Et";

  final String dtViewAppBarText = "Zaman ve Tarih Seçimi";

  final String tViewHeaderText = "Randevu Saatleri";

  final String tViewADTitleText = "Randevu Alma";

  final String tViewADContentText1 = " tarihinde ";

  final String tViewADContentText2 =
      " saatine randevu almak istediğinize emin misiniz?";

  final String tViewADCancelButtonText = "İptal";

  final String tViewADtAppoinmentBText = "Randevu Al";

  final String ariViewAppBarText = "Randevu Sonuç Bilgileri";

  final String ariViewSuccessText = "Randevu Başarıyla Alındı.";

  final String ariViewPatientInfoHeader = "Hasta Bilgileri";

  final String ariViewPatientInfoText1 = "Hasta Adı: ";

  final String ariViewPatientInfoText2 = "Hasta Soyadı: ";

  final String ariViewPatientInfoText3 = "Hasta TC: ";

  final String ariViewAppointmentInfoHeader = "Randevu Bilgileri";

  final String ariViewAppointmentInfoText1 = "Doktor Adı: ";

  final String ariViewAppointmentInfoText2 = "Doktor Soyadı: ";

  final String ariViewAppointmentInfoText3 = "Hastane Adı: ";

  final String ariViewAppointmentInfoText4 = "Poliklinik Adı: ";

  final String ariViewAppointmentInfoText5 = "Randevu Saati: ";

  final String ariViewAppointmentInfoText6 = "Randevu Tarihi: ";

  //Register Strings
  final String rwAppBarText = "Kayıt Ol";

  final String rwFNHintText = "Adınızı Giriniz";

  final String rwLNHintText = "Soyadınızı Giriniz";

  final String rwIdentityHintText = "TC Kimlik Numaranızı Giriniz";

  final String rwBirthDateHintText = "Doğum Tarihinizi Giriniz";

  final String rwBloodHintText = "Kan Grubunuzu Seçiniz";

  final String rwGenderHintText = "Cinsiyetinizi Seçiniz";

  //Personal Strings
  final String phwDContainerWelcomeText = "Hoşgeldiniz";

  final String phwQLTileTitleText = "Soruları Cevapla";

  final String phwQLTileSubtitleText =
      "Hastalarımızın Siz Değerli Doktorlarımıza Sormuş Olduğu Soruları Cevaplayın";

  final String pfqwAppBarText = "Poliklinik Seçin";

  final String pfqwPolyclinicSButton = "Göz At";

  final String apqwTFHintText = "Cevabınızı Giriniz";

  final String apqwADTitleText = "Soru Cevaplama";

  final String apqwADContentText =
      "Cevap gönderebilmek için lütfen bir mesaj giriniz";

  final String apqwADButtonText = "Tamam";

  final String apqwAnswerBText = "Cevapla";
}
