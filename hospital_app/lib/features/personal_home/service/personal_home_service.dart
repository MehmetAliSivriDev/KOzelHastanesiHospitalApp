import 'dart:convert';
import 'dart:io';

import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/personal_home/model/doctor_answer_model.dart';
import 'package:hospital_app/features/personal_home/model/patient_questions_model.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

abstract class IPersonalHomeService {
  Future<List<PolyclinicModel>?> fetchPolyclinics();
  Future<List<PatientQuestionsModel>?> fetchQuestionsWithPolyclinic(
      String polyclinicName);
  Future<int?> postDoctorAnswer(DoctorAnswerModel doctorAnswerModel);
}

class PersonalHomeService extends IPersonalHomeService {
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
  Future<List<PatientQuestionsModel>?> fetchQuestionsWithPolyclinic(
      String polyclinicName) async {
    Map<String, String> body = {"poliklinik": polyclinicName};

    final response = await http.post(
        ProductNetworkManager.instance.getPatientQuestionsWithPolyclinicUri,
        body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);

      return _dataFromApi =
          _dataFromApi.map((e) => PatientQuestionsModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<int?> postDoctorAnswer(DoctorAnswerModel doctorAnswerModel) async {
    final response = await http.post(
        ProductNetworkManager.instance.postDoctorAnswerUri,
        body: doctorAnswerModel.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return json.decode(response.body);
    } else {
      return 0;
    }
  }
}
