class RegisterModel {
  String? hastaEposta;
  String? hastaAdi;
  String? hastaSoyadi;
  String? hastaTC;
  String? hastaSifre;
  String? dogumTarihi;
  String? kan;
  String? cinsiyet;

  RegisterModel(
      {this.hastaEposta,
      this.hastaAdi,
      this.hastaSoyadi,
      this.hastaTC,
      this.hastaSifre,
      this.dogumTarihi,
      this.kan,
      this.cinsiyet});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    hastaEposta = json['hasta_eposta'];
    hastaAdi = json['hasta_adi'];
    hastaSoyadi = json['hasta_soyadi'];
    hastaTC = json['hasta_TC'];
    hastaSifre = json['hasta_sifre'];
    dogumTarihi = json['dogum_tarihi'];
    kan = json['kan'];
    cinsiyet = json['cinsiyet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasta_eposta'] = this.hastaEposta;
    data['hasta_adi'] = this.hastaAdi;
    data['hasta_soyadi'] = this.hastaSoyadi;
    data['hasta_TC'] = this.hastaTC;
    data['hasta_sifre'] = this.hastaSifre;
    data['dogum_tarihi'] = this.dogumTarihi;
    data['kan'] = this.kan;
    data['cinsiyet'] = this.cinsiyet;
    return data;
  }
}
