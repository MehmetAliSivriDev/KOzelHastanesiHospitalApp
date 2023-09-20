import 'package:flutter/material.dart';

class ProductPaddings extends EdgeInsets {
  const ProductPaddings.bodyPadding() : super.all(15);
  const ProductPaddings.pLButtonPadding() : super.only(right: 20);
  const ProductPaddings.homeViewMBPadding() : super.only(right: 10);
  const ProductPaddings.authImagePadding() : super.only(bottom: 50);
  const ProductPaddings.txtFormFieldPadding()
      : super.only(top: 20, left: 12, right: 12);
  const ProductPaddings.homeLTileContainerPadding() : super.only(top: 30);
  const ProductPaddings.pqViewButtonPadding() : super.only(top: 30);
  const ProductPaddings.lottieLoadingPadding() : super.all(45.0);
  const ProductPaddings.appointmentContentExpPadding() : super.all(5.0);
  const ProductPaddings.dateLTContainerContentPadding()
      : super.only(left: 15, right: 15, top: 10, bottom: 10);
  const ProductPaddings.appointmetTimesPadding()
      : super.symmetric(vertical: 20, horizontal: 20);
  const ProductPaddings.infoCardPadding() : super.only(bottom: 10);
  const ProductPaddings.pmCardPadding() : super.only(bottom: 20);
  const ProductPaddings.pmViewICIconPadding() : super.only(left: 10, right: 10);
}
