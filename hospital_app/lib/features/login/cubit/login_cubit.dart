import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/core/cache/cache_manager.dart';
import 'package:hospital_app/features/home/view/home_view.dart';
import 'package:hospital_app/features/login/model/login_model.dart';
import 'package:hospital_app/features/login/model/personal_login_model.dart';
import 'package:hospital_app/features/login/service/login_service.dart';
import 'package:hospital_app/features/personal_home/view/personal_home_view.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:kartal/kartal.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with CacheManager, ShowLottie {
  LoginCubit(this.loginService, this.context) : super(const LoginState()) {
    removeEmail();
    removeId();
  }

  final LoginService loginService;
  final BuildContext context;

  Future<void> fetchPatientLogin(String email, String password) async {
    changeLoading();

    final response = await loginService.fetchPatientLogin(
        LoginModel(hastaEposta: email, hastaSifre: password));
    await Future.delayed(const Duration(seconds: 2));
    changeLoading();

    if (response != null && response != "Login Failed.") {
      saveEmail(response.replaceAll('"', ''));
      navigateToHome();
    } else {
      if (context.mounted) {
        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.mainRed,
            elevation: 30,
            content: Text(
              "Giriş Başarısız.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> fetchPersonalLogin(String email, String password) async {
    changeLoading();

    final response = await loginService.fetchPersonalLogin(
        PersonalLoginModel(doktorEposta: email, doktorSifre: password));
    await Future.delayed(const Duration(seconds: 2));
    changeLoading();

    if (response != null && response != "Login Failed.") {
      saveEmail(response.replaceAll('"', ''));
      navigateToPersonalHome();
    } else {
      if (context.mounted) {
        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.mainRed,
            elevation: 30,
            content: Text(
              "Giriş Başarısız.",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void changeLoading() {
    emit(state.copyWith(isLogin: !(state.isLogin ?? false)));

    if (state.isLogin == true) {
      showLottie(context);
    } else {
      Navigator.pop(context);
    }
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeView()));
  }

  void navigateToPersonalHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const PersonalHomeView(),
      ),
      (route) => false, // Tüm geçmişi temizle
    );
  }
}
