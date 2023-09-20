import 'dart:convert';
import 'dart:io';

import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/home/model/patient_message_model.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

abstract class IHomeService {
  Future<List<PolyclinicModel>?> fetchPolyclinics();
  Future<int?> patientAskQuestion(
      String eposta, String polyclinic, String question);
  Future<List<PatientMessageModel>?> fetchPatientMessages(String eposta);
  Future<int?> updatePatientInfo(String eposta, String phone, String adress,
      String birthPlace, String birthDate, String blood, String gender);
}

class HomeService extends IHomeService {
  List _dataFromApi = [];

  @override
  Future<List<PolyclinicModel>?> fetchPolyclinics() async {
    final response =
        await http.get(ProductNetworkManager.instance.getPolyclinicsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);

      return _dataFromApi =
          _dataFromApi.map((e) => PolyclinicModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<int?> patientAskQuestion(
      String eposta, String polyclinic, String question) async {
    Map<String, String> body = {
      "hasta_eposta": eposta,
      "poliklinik": polyclinic,
      "soru": question,
    };

    final response = await http.post(
        ProductNetworkManager.instance.postPatientQuestionUri,
        body: body);

    if (response.statusCode == HttpStatus.ok) {
      return int.parse(response.body);
    } else {
      return 0;
    }
  }

  @override
  Future<List<PatientMessageModel>?> fetchPatientMessages(String eposta) async {
    Map<String, String> body = {"hasta_eposta": eposta};

    final response = await http
        .post(ProductNetworkManager.instance.getPatientMessagesUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);

      return _dataFromApi =
          _dataFromApi.map((e) => PatientMessageModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<int?> updatePatientInfo(String eposta, String phone, String adress,
      String birthPlace, String birthDate, String blood, String gender) async {
    if (gender == "Erkek") {
      gender = "0";
    } else if (gender == "Kız") {
      gender = "1";
    }
    Map<String, String> body = {
      "hasta_eposta": eposta,
      "telefon": phone,
      "adres": adress,
      "dogum_yeri": birthPlace,
      "dogum_tarihi": birthDate,
      "kan": blood,
      "cinsiyet": gender
    };

    final response = await http
        .post(ProductNetworkManager.instance.updatePatientInfoUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      return int.parse(response.body);
    } else {
      return 0;
    }
  }
}
