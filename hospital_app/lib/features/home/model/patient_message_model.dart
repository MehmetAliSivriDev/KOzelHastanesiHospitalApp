class PatientMessageModel {
  String? doktorAdi;
  String? doktorSoyadi;
  String? hastaSoru;
  String? poliklinik;
  String? cevap;

  PatientMessageModel(
      {this.doktorAdi,
      this.doktorSoyadi,
      this.hastaSoru,
      this.poliklinik,
      this.cevap});

  PatientMessageModel.fromJson(Map<String, dynamic> json) {
    doktorAdi = json['doktor_adi'];
    doktorSoyadi = json['doktor_soyadi'];
    hastaSoru = json['hasta_soru'];
    poliklinik = json['poliklinik'];
    cevap = json['cevap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktor_adi'] = this.doktorAdi;
    data['doktor_soyadi'] = this.doktorSoyadi;
    data['hasta_soru'] = this.hastaSoru;
    data['poliklinik'] = this.poliklinik;
    data['cevap'] = this.cevap;
    return data;
  }
}
