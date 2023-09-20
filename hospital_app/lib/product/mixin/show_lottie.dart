import 'package:flutter/material.dart';
import 'package:hospital_app/product/extensions/lottie_paths.dart';
import 'package:lottie/lottie.dart';

mixin ShowLottie {
  void showLottie(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Lottie.asset(LottiePaths.loading.getPath()),
    );

    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
