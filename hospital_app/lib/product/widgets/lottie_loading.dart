import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/extensions/lottie_paths.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProductPaddings.lottieLoadingPadding(),
      child: Center(
        child: Card(child: Lottie.asset(LottiePaths.loading.getPath())),
      ),
    );
  }
}
