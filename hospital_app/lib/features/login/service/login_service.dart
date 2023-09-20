import 'dart:io';
import 'package:hospital_app/features/login/model/personal_login_model.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';

abstract class ILoginService {
  Future<String?> fetchPatientLogin(LoginModel loginModel);
  Future<String?> fetchPersonalLogin(PersonalLoginModel personalLoginModel);
}

class LoginService extends ILoginService {
  @override
  Future<String?> fetchPatientLogin(LoginModel loginModel) async {
    final response = await http.post(
        ProductNetworkManager.instance.loginPatientUri,
        body: loginModel.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      return "Login Failed.";
    }
  }

  @override
  Future<String?> fetchPersonalLogin(
      PersonalLoginModel personalLoginModel) async {
    final response = await http.post(
        ProductNetworkManager.instance.personalLoginUri,
        body: personalLoginModel.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      return "Login Failed.";
    }
  }
}
