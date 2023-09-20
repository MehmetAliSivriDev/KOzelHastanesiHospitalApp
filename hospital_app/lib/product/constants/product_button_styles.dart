import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_colors.dart';

class ProductButtonStyles extends ButtonStyle {
  ProductButtonStyles.registerBStyle()
      : super(
            side: MaterialStateProperty.all(
                BorderSide(color: ProductColors.instance.mainRed)),
            foregroundColor:
                MaterialStateProperty.all(ProductColors.instance.mainRed));

  ProductButtonStyles.personalLoginBStyle()
      : super(
            side: MaterialStateProperty.all(
                BorderSide(color: ProductColors.instance.customBlue)));

  ProductButtonStyles.pUpdateInfoBStyle()
      : super(
            elevation: MaterialStateProperty.all(5),
            backgroundColor:
                MaterialStateProperty.all(ProductColors.instance.mainRed));
}
