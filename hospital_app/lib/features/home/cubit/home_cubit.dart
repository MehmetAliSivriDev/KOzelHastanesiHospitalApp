import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/core/base/model/patient_model.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/core/cache/cache_manager.dart';
import 'package:hospital_app/features/appointment/model/polyclinic_model.dart';
import 'package:hospital_app/features/home/model/patient_message_model.dart';
import 'package:hospital_app/features/home/service/home_service.dart';
import 'package:hospital_app/features/home/view/home_view.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/constants/product_durations.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:kartal/kartal.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with CacheManager, ShowLottie {
  HomeCubit(this.baseService, this.homeService) : super(const HomeState()) {
    initalComplete();
  }

  final BaseService baseService;
  final HomeService homeService;

  Future<void> initalComplete() async {
    await loadEmail();
    await fetchPatientWithEmail();
    await fetchPolyclinics();
    await getPatientMessages(state.email!);
  }

  Future<void> postPatientQuestion(String eposta, String polyclinic,
      String question, BuildContext context) async {
    final response =
        await homeService.patientAskQuestion(eposta, polyclinic, question);

    if (response == 1) {
      if (context.mounted) {
        Navigator.pop(context);
        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.successGreen,
            elevation: 30,
            content: Text(
              "Sorunuz Başarıyla İletildi.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        Future.delayed(ProductDurations.imageRowDuration);
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

  Future<void> getPatientMessages(String eposta) async {
    final response = await homeService.fetchPatientMessages(eposta);
    emit(state.copyWith(patientMessages: response));
  }

  Future<void> fetchPolyclinics() async {
    final response = await homeService.fetchPolyclinics();
    emit(state.copyWith(polyclinics: response));
  }

  Future<void> loadEmail() async {
    emit(state.copyWith(email: await getEmail()));
  }

  Future<void> fetchPatientWithEmail() async {
    final response = await baseService.fetchPatientWithEmail(state.email!);

    emit(state.copyWith(patientModel: response));
  }

  Future<void> updatePatientInfo(
      BuildContext context,
      String eposta,
      String phone,
      String adress,
      String birthPlace,
      String birthDate,
      String blood,
      String gender) async {
    final response = await homeService.updatePatientInfo(
        eposta, phone, adress, birthPlace, birthDate, blood, gender);

    if (context.mounted) {
      showLottie(context);
    }

    await Future.delayed(const Duration(seconds: 2));

    if (response == 1) {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false, // Tüm geçmişi temizle
        );
        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.successGreen,
            elevation: 30,
            content: Text(
              "Bilgileriniz Başarıyla Güncellendi.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false, // Tüm geçmişi temizle
        );
        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.mainRed,
            elevation: 30,
            content: Text(
              "Bilgileriniz Güncellenirken Bir Hata Meydana Geldi.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
