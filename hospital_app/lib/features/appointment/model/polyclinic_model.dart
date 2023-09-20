class PolyclinicModel {
  String? polikilinikId;
  String? polikilinikAdi;

  PolyclinicModel({this.polikilinikId, this.polikilinikAdi});

  PolyclinicModel.fromJson(Map<String, dynamic> json) {
    polikilinikId = json['polikilinik_id'];
    polikilinikAdi = json['polikilinik_adi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['polikilinik_id'] = this.polikilinikId;
    data['polikilinik_adi'] = this.polikilinikAdi;
    return data;
  }
}
