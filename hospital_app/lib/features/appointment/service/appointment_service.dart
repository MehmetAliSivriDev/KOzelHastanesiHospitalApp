import 'dart:convert';
import 'dart:io';

import 'package:hospital_app/features/appointment/model/appointment_result_information_model.dart';
import 'package:hospital_app/features/appointment/model/date_model.dart';
import 'package:hospital_app/features/appointment/model/hospital_model.dart';
import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/appointment/model/time_model.dart';
import 'package:hospital_app/product/network/product_network_manager.dart';
import 'package:http/http.dart' as http;

import '../../../core/base/model/doctor_model.dart';

abstract class IAppointmentService {
  Future<List<HospitalModel>?> fetchHospitals();
  Future<List<PolyclinicModel>?> fetchPolyclinics();
  Future<List<DoctorModel>?> fetchDoctorWithIDs(
      int hospitalId, int polyclinicId);
  Future<List<DateModel>?> fetchDates(int doctorId);
  Future<List<TimeModel>?> fetchTimes(int doctorId, String date);
  Future<int?> takeAppointment(
      int doctorId, int patientId, String date, String time);
  Future<AppointmentResultInformationModel?> fetchAppointmentResult(
      int doctorId, int patientId, String date, String time);
}

class AppointmentService extends IAppointmentService {
  List _dataFromApi = [];

  @override
  Future<List<HospitalModel>?> fetchHospitals() async {
    final response =
        await http.get(ProductNetworkManager.instance.getHospitalsUri);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);

      return _dataFromApi.map((e) => HospitalModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

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
  Future<List<DoctorModel>?> fetchDoctorWithIDs(
      int hospitalId, int polyclinicId) async {
    Map<String, String> body = {
      "poliklinik_id": polyclinicId.toString(),
      "hastane_id": hospitalId.toString()
    };
    final response = await http
        .post(ProductNetworkManager.instance.getDoctorsWithIDsUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      return _dataFromApi.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<DateModel>?> fetchDates(int doctorId) async {
    Map<String, String> body = {"doktor_id": doctorId.toString()};

    final response =
        await http.post(ProductNetworkManager.instance.getDateUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      return _dataFromApi.map((e) => DateModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<TimeModel>?> fetchTimes(int doctorId, String date) async {
    Map<String, String> body = {
      "doktor_id": doctorId.toString(),
      "calisma_tarihi": date
    };

    final response =
        await http.post(ProductNetworkManager.instance.getTimeUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      return _dataFromApi.map((e) => TimeModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<int?> takeAppointment(
      int doctorId, int patientId, String date, String time) async {
    Map<String, String> body = {
      "doktor_id": doctorId.toString(),
      "hasta_id": patientId.toString(),
      "randevu_tarihi": date,
      "randevu_saati": time
    };

    final response = await http
        .post(ProductNetworkManager.instance.takeAppointmentUri, body: body);

    if (response.statusCode == HttpStatus.ok) {
      return int.parse(response.body);
    } else {
      return 0;
    }
  }

  @override
  Future<AppointmentResultInformationModel?> fetchAppointmentResult(
      int doctorId, int patientId, String date, String time) async {
    Map<String, String> body = {
      "doktor_id": doctorId.toString(),
      "hasta_id": patientId.toString(),
      "randevu_tarihi": date,
      "randevu_saati": time,
    };
    final response = await http.post(
        ProductNetworkManager.instance.getAppointmentResultInfoUri,
        body: body);

    if (response.statusCode == HttpStatus.ok) {
      _dataFromApi = json.decode(response.body);
      _dataFromApi = _dataFromApi
          .map((e) => AppointmentResultInformationModel.fromJson(e))
          .toList();
      return _dataFromApi.first;
    } else {
      return AppointmentResultInformationModel();
    }
  }
}
