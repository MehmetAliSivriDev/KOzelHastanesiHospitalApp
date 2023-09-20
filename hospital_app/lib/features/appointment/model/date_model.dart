class DateModel {
  String? calismaTarihi;

  DateModel({this.calismaTarihi});

  DateModel.fromJson(Map<String, dynamic> json) {
    calismaTarihi = json['calisma_tarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calisma_tarihi'] = this.calismaTarihi;
    return data;
  }
}
