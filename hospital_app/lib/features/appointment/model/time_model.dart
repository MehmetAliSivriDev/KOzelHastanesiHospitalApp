class TimeModel {
  String? calismaSaatiId;
  String? calismaSaati;
  String? doluMu;
  String? doktorId;
  String? calismaTarihi;

  TimeModel(
      {this.calismaSaatiId,
      this.calismaSaati,
      this.doluMu,
      this.doktorId,
      this.calismaTarihi});

  TimeModel.fromJson(Map<String, dynamic> json) {
    calismaSaatiId = json['calisma_saati_id'];
    calismaSaati = json['calisma_saati'];
    doluMu = json['doluMu'];
    doktorId = json['doktor_id'];
    calismaTarihi = json['calisma_tarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calisma_saati_id'] = this.calismaSaatiId;
    data['calisma_saati'] = this.calismaSaati;
    data['doluMu'] = this.doluMu;
    data['doktor_id'] = this.doktorId;
    data['calisma_tarihi'] = this.calismaTarihi;
    return data;
  }
}
