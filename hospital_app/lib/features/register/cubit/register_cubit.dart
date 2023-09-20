import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/features/login/view/login_view.dart';
import 'package:hospital_app/features/register/model/register_model.dart';
import 'package:hospital_app/features/register/service/register_service.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:kartal/kartal.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> with ShowLottie {
  RegisterCubit(this.registerService, this.context)
      : super(const RegisterState());

  final IRegisterService registerService;
  final BuildContext context;

  Future<void> register(RegisterModel registerModel) async {
    if (context.mounted) showLottie(context);
    final response = await registerService.register(registerModel);

    if (response != null && response.result != null && response.result != 0) {
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
          (route) => false, // Tüm geçmişi temizle
        );

        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.successGreen,
            elevation: 30,
            content: Text(
              response.message ?? "Başarılı",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
          (route) => false, // Tüm geçmişi temizle
        );

        final snackBar = SnackBar(
            backgroundColor: ProductColors.instance.mainRed,
            elevation: 30,
            content: Text(
              response?.message ?? "Başarısız",
              style: context.general.textTheme.titleMedium,
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
