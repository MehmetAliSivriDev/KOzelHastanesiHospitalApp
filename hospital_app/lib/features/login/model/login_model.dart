class LoginModel {
  String? hastaEposta;
  String? hastaSifre;

  LoginModel({this.hastaEposta, this.hastaSifre});

  LoginModel.fromJson(Map<String, dynamic> json) {
    hastaEposta = json['hasta_eposta'];
    hastaSifre = json['hasta_sifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasta_eposta'] = this.hastaEposta;
    data['hasta_sifre'] = this.hastaSifre;
    return data;
  }
}
