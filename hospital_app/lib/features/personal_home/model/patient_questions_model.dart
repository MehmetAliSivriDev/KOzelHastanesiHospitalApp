class PatientQuestionsModel {
  String? hastaSoruId;
  String? hastaEposta;
  String? poliklinik;
  String? soru;

  PatientQuestionsModel(
      {this.hastaSoruId, this.hastaEposta, this.poliklinik, this.soru});

  PatientQuestionsModel.fromJson(Map<String, dynamic> json) {
    hastaSoruId = json['hasta_soru_id'];
    hastaEposta = json['hasta_eposta'];
    poliklinik = json['poliklinik'];
    soru = json['soru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasta_soru_id'] = this.hastaSoruId;
    data['hasta_eposta'] = this.hastaEposta;
    data['poliklinik'] = this.poliklinik;
    data['soru'] = this.soru;
    return data;
  }
}
