class HospitalModel {
  String? hastaneId;
  String? hastaneAdi;
  String? hastaneKonum;

  HospitalModel({this.hastaneId, this.hastaneAdi, this.hastaneKonum});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    hastaneId = json['hastane_id'];
    hastaneAdi = json['hastane_adi'];
    hastaneKonum = json['hastane_konum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hastane_id'] = this.hastaneId;
    data['hastane_adi'] = this.hastaneAdi;
    data['hastane_konum'] = this.hastaneKonum;
    return data;
  }
}
