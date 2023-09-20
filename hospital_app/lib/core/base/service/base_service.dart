import 'dart:convert';
import 'dart:io';
import 'package:hospital_app/core/base/model/doctor_model.dart';
import 'package:hospital_app/core/base/model/patient_model.dart';
import 'package:hospital_app/core/cache/cache_manager.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

abstract class IBaseService {
  Future<List<DoctorModel>?> fetchAllDoctors();
  Future<List<PatientModel>?> fetchAllPatients();
  Future<PatientModel?> fetchPatientWithEmail(String email);
  Future<DoctorModel?> fetchDoctorWithEmail(String email);
}

class BaseService extends IBaseService with CacheManager {
  List _dataFromApi = [];

  @override
  Future<List<PatientModel>?> fetchAllPatients() async {
    final response =
        await http.get(ProductNetworkManager.instance.getPatientsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      return _dataFromApi.map((e) => PatientModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<DoctorModel>?> fetchAllDoctors() async {
    final response =
        await http.get(ProductNetworkManager.instance.getDoctorsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      return _dataFromApi.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<PatientModel?> fetchPatientWithEmail(String email) async {
    final response =
        await http.get(ProductNetworkManager.instance.getPatientsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      _dataFromApi = _dataFromApi.map((e) => PatientModel.fromJson(e)).toList();
      _dataFromApi = _dataFromApi
          .where((element) => element.hastaEposta == email)
          .toList();

      saveId(int.parse(_dataFromApi.first.hastaId));

      return _dataFromApi.first;
    } else {
      return PatientModel();
    }
  }

  @override
  Future<DoctorModel?> fetchDoctorWithEmail(String email) async {
    final response =
        await http.get(ProductNetworkManager.instance.getDoctorsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      _dataFromApi = _dataFromApi.map((e) => DoctorModel.fromJson(e)).toList();
      _dataFromApi = _dataFromApi
          .where((element) => element.doktorEposta == email)
          .toList();

      saveId(int.parse(_dataFromApi.first.doktorId));

      return _dataFromApi.first;
    } else {
      return DoctorModel();
    }
  }
}
