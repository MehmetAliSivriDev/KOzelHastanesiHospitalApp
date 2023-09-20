import 'dart:convert';
import 'dart:io';

import 'package:hospital_app/features/register/model/register_model.dart';
import 'package:hospital_app/features/register/model/register_response_model.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

abstract class IRegisterService {
  Future<RegisterResponseModel?> register(RegisterModel registerModel);
}

class RegisterService extends IRegisterService {
  // List _dataFromApi = [];

  @override
  Future<RegisterResponseModel?> register(RegisterModel registerModel) async {
    final response = await http.post(ProductNetworkManager.instance.registerUri,
        body: registerModel.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      return RegisterResponseModel();
    }
  }
}
