class RegisterResponseModel {
  String? message;
  int? result;

  RegisterResponseModel({this.message, this.result});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    result = json['Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Result'] = this.result;
    return data;
  }
}
