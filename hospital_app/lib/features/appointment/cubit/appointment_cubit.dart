import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/core/base/model/doctor_model.dart';
import 'package:hospital_app/core/cache/cache_manager.dart';
import 'package:hospital_app/features/appointment/model/appointment_result_information_model.dart';
import 'package:hospital_app/features/appointment/model/date_model.dart';
import 'package:hospital_app/features/appointment/model/hospital_model.dart';
import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/appointment/model/time_model.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/features/appointment/view/appointment_result_information_view.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:kartal/kartal.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState>
    with CacheManager, ShowLottie {
  AppointmentCubit(this.appointmentService, this.context)
      : super(const AppointmentState());
  final IAppointmentService appointmentService;
  final BuildContext context;

  Future<void> fetchHospital() async {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));

    final response = await appointmentService.fetchHospitals();
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
        hospitals: response, isLoading: !(state.isLoading ?? false)));
  }

  Future<void> fetchPolyclinics() async {
    final response = await appointmentService.fetchPolyclinics();
    emit(state.copyWith(polyclinics: response));
  }

  Future<void> fetchDoctors(int hospitalId, int polyclinicId) async {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
    final response =
        await appointmentService.fetchDoctorWithIDs(hospitalId, polyclinicId);
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
        doctors: response, isLoading: !(state.isLoading ?? false)));
  }

  Future<void> getPatientId() async {
    emit(state.copyWith(patientId: await getId()));
  }

  Future<void> getDates(int doctorId) async {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
    final response = await appointmentService.fetchDates(doctorId);
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        dates: response, isLoading: !(state.isLoading ?? false)));
  }

  Future<void> getTimes(int doctorId, String date) async {
    final response = await appointmentService.fetchTimes(doctorId, date);
    emit(state.copyWith(times: response));
  }

  Future<int?> takeAppointment(
      int doctorId, int patientId, String date, String time) async {
    final response = await appointmentService.takeAppointment(
        doctorId, patientId, date, time);

    return response;
  }

  Future<AppointmentResultInformationModel?> getAppointmentResult(
      int doctorId, int patientId, String date, String time) async {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
    final response = await appointmentService.fetchAppointmentResult(
        doctorId, patientId, date, time);
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        appointmentResultInformationModel: response,
        isLoading: !(state.isLoading ?? false)));
    return response;
  }

  Future<void> checkAndNavigateForAppointment(
      int response, int doctorId, String date, String time) async {
    if (response == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentResultInformationView(
            date: date,
            time: time,
            doctorId: doctorId,
            patientId: state.patientId ?? 0,
          ),
        ),
        (route) => false, // Tüm geçmişi temizle
      );
    } else {
      AlertDialog alertdialog = AlertDialog(
        title: const Text("Randevu Alma"),
        content: const Text("Randevu Alma Başarısız Oldu."),
        actions: [
          FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  Text("Tamam", style: context.general.textTheme.titleMedium))
        ],
      );

      showDialog(context: context, builder: (_) => alertdialog);
    }
  }
}
