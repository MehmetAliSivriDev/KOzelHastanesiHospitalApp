import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/core/base/model/doctor_model.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/core/cache/cache_manager.dart';
import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/personal_home/model/doctor_answer_model.dart';
import 'package:hospital_app/features/personal_home/model/patient_questions_model.dart';
import 'package:hospital_app/features/personal_home/service/personal_home_service.dart';
import 'package:kartal/kartal.dart';

import '../../../product/constants/product_colors.dart';

part 'personal_home_state.dart';

class PersonalHomeCubit extends Cubit<PersonalHomeState> with CacheManager {
  PersonalHomeCubit(this.baseService, this.personalHomeService, this.context)
      : super(const PersonalHomeState());

  final BaseService baseService;
  final PersonalHomeService personalHomeService;
  final BuildContext context;

  Future<void> initalComplete() async {
    await loadEmail();
    await getDoctorInfo(state.email!);
  }

  Future<void> getDoctorInfo(String email) async {
    final response = await baseService.fetchDoctorWithEmail(email);

    emit(state.copyWith(doctorModel: response));
  }

  Future<void> fetchPolyclinics() async {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
    await Future.delayed(const Duration(seconds: 2));
    final response = await personalHomeService.fetchPolyclinics();
    emit(state.copyWith(
        polyclinics: response, isLoading: !(state.isLoading ?? false)));
  }

  Future<void> getPatientQuestionsWithPolyclinic(String polyclinicName) async {
    final response =
        await personalHomeService.fetchQuestionsWithPolyclinic(polyclinicName);
    emit(state.copyWith(questions: response));
  }

  Future<void> postDoctorAnswer(DoctorAnswerModel doctorAnswerModel) async {
    final response =
        await personalHomeService.postDoctorAnswer(doctorAnswerModel);

    if (response != null && response == 1) {
      if (context.mounted) {
        Navigator.pop(context);

        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.successGreen,
            elevation: 30,
            content: Text(
              "Cevabınız Başarıyla İletildi.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);

        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.mainRed,
            elevation: 30,
            content: Text(
              "Bir Hata Meydana Geldi.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> getDoctorId() async {
    emit(state.copyWith(doctorId: await getId()));
  }

  Future<void> loadEmail() async {
    emit(state.copyWith(email: await getEmail()));
  }
}
