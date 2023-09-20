import 'package:equatable/equatable.dart';

class PatientModel with EquatableMixin {
  String? hastaId;
  String? hastaAdi;
  String? hastaSoyadi;
  String? hastaTC;
  String? hastaEposta;
  String? hastaCinsiyet;
  String? hastaTelefon;
  String? hastaDogumTarihi;
  String? hastaDogumYeri;
  String? hastaAdress;
  String? hastaKan;
  String? hastaSifre;

  PatientModel(
      {this.hastaId,
      this.hastaAdi,
      this.hastaSoyadi,
      this.hastaTC,
      this.hastaEposta,
      this.hastaCinsiyet,
      this.hastaTelefon,
      this.hastaDogumTarihi,
      this.hastaDogumYeri,
      this.hastaAdress,
      this.hastaKan,
      this.hastaSifre});

  PatientModel.fromJson(Map<String, dynamic> json) {
    hastaId = json['hasta_id'];
    hastaAdi = json['hasta_adi'];
    hastaSoyadi = json['hasta_soyadi'];
    hastaTC = json['hasta_TC'];
    hastaEposta = json['hasta_eposta'];
    hastaCinsiyet = json['hasta_cinsiyet'];
    hastaTelefon = json['hasta_telefon'];
    hastaDogumTarihi = json['hasta_dogum_tarihi'];
    hastaDogumYeri = json['hasta_dogum_yeri'];
    hastaAdress = json['hasta_adress'];
    hastaKan = json['hasta_kan'];
    hastaSifre = json['hasta_sifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasta_id'] = this.hastaId;
    data['hasta_adi'] = this.hastaAdi;
    data['hasta_soyadi'] = this.hastaSoyadi;
    data['hasta_TC'] = this.hastaTC;
    data['hasta_eposta'] = this.hastaEposta;
    data['hasta_cinsiyet'] = this.hastaCinsiyet;
    data['hasta_telefon'] = this.hastaTelefon;
    data['hasta_dogum_tarihi'] = this.hastaDogumTarihi;
    data['hasta_dogum_yeri'] = this.hastaDogumYeri;
    data['hasta_adress'] = this.hastaAdress;
    data['hasta_kan'] = this.hastaKan;
    data['hasta_sifre'] = this.hastaSifre;
    return data;
  }

  @override
  List<Object?> get props => [hastaId];
}
