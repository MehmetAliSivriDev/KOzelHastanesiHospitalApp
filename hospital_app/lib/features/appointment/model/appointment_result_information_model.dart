class AppointmentResultInformationModel {
  String? doktorAdi;
  String? doktorSoyadi;
  String? hastaAdi;
  String? hastaSoyadi;
  String? hastaTC;
  String? polikilinikAdi;
  String? hastaneAdi;
  String? randevuSaati;
  String? randevuTarihi;

  AppointmentResultInformationModel(
      {this.doktorAdi,
      this.doktorSoyadi,
      this.hastaAdi,
      this.hastaSoyadi,
      this.hastaTC,
      this.polikilinikAdi,
      this.hastaneAdi,
      this.randevuSaati,
      this.randevuTarihi});

  AppointmentResultInformationModel.fromJson(Map<String, dynamic> json) {
    doktorAdi = json['doktor_adi'];
    doktorSoyadi = json['doktor_soyadi'];
    hastaAdi = json['hasta_adi'];
    hastaSoyadi = json['hasta_soyadi'];
    hastaTC = json['hasta_TC'];
    polikilinikAdi = json['polikilinik_adi'];
    hastaneAdi = json['hastane_adi'];
    randevuSaati = json['randevu_saati'];
    randevuTarihi = json['randevu_tarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktor_adi'] = this.doktorAdi;
    data['doktor_soyadi'] = this.doktorSoyadi;
    data['hasta_adi'] = this.hastaAdi;
    data['hasta_soyadi'] = this.hastaSoyadi;
    data['hasta_TC'] = this.hastaTC;
    data['polikilinik_adi'] = this.polikilinikAdi;
    data['hastane_adi'] = this.hastaneAdi;
    data['randevu_saati'] = this.randevuSaati;
    data['randevu_tarihi'] = this.randevuTarihi;
    return data;
  }
}
