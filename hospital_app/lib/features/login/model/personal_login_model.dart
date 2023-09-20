class PersonalLoginModel {
  String? doktorEposta;
  String? doktorSifre;

  PersonalLoginModel({this.doktorEposta, this.doktorSifre});

  PersonalLoginModel.fromJson(Map<String, dynamic> json) {
    doktorEposta = json['doktor_eposta'];
    doktorSifre = json['doktor_sifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktor_eposta'] = this.doktorEposta;
    data['doktor_sifre'] = this.doktorSifre;
    return data;
  }
}
