class ResponseModel {
  String? hastaEposta;

  ResponseModel({this.hastaEposta});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    hastaEposta = json['hasta_eposta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasta_eposta'] = this.hastaEposta;
    return data;
  }
}
