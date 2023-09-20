class DoctorAnswerModel {
  String? doktorId;
  String? hastaEposta;
  String? poliklinik;
  String? soru;
  String? cevap;

  DoctorAnswerModel(
      {this.doktorId,
      this.hastaEposta,
      this.poliklinik,
      this.soru,
      this.cevap});

  DoctorAnswerModel.fromJson(Map<String, dynamic> json) {
    doktorId = json['doktor_id'];
    hastaEposta = json['hasta_eposta'];
    poliklinik = json['poliklinik'];
    soru = json['soru'];
    cevap = json['cevap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktor_id'] = this.doktorId;
    data['hasta_eposta'] = this.hastaEposta;
    data['poliklinik'] = this.poliklinik;
    data['soru'] = this.soru;
    data['cevap'] = this.cevap;
    return data;
  }
}
