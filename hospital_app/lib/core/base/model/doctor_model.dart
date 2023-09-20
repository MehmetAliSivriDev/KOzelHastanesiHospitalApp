import 'package:equatable/equatable.dart';

class DoctorModel with EquatableMixin {
  String? doktorId;
  String? doktorAdi;
  String? doktorSoyadi;
  String? doktorCinsiyet;
  String? dogumTarihi;
  String? polikilinikId;
  String? hastaneId;
  String? doktorEposta;
  String? doktorSifre;

  DoctorModel(
      {this.doktorId,
      this.doktorAdi,
      this.doktorSoyadi,
      this.doktorCinsiyet,
      this.dogumTarihi,
      this.polikilinikId,
      this.hastaneId,
      this.doktorEposta,
      this.doktorSifre});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doktorId = json['doktor_id'];
    doktorAdi = json['doktor_adi'];
    doktorSoyadi = json['doktor_soyadi'];
    doktorCinsiyet = json['doktor_cinsiyet'];
    dogumTarihi = json['dogum_tarihi'];
    polikilinikId = json['polikilinik_id'];
    hastaneId = json['hastane_id'];
    doktorEposta = json['doktor_eposta'];
    doktorSifre = json['doktor_sifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktor_id'] = this.doktorId;
    data['doktor_adi'] = this.doktorAdi;
    data['doktor_soyadi'] = this.doktorSoyadi;
    data['doktor_cinsiyet'] = this.doktorCinsiyet;
    data['dogum_tarihi'] = this.dogumTarihi;
    data['polikilinik_id'] = this.polikilinikId;
    data['hastane_id'] = this.hastaneId;
    data['doktor_eposta'] = this.doktorEposta;
    data['doktor_sifre'] = this.doktorSifre;
    return data;
  }

  @override
  List<Object?> get props => [doktorId];
}
