import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_colors.dart';

class ProductBoxDecoration extends BoxDecoration {
  ProductBoxDecoration.homeLTileContainerBDecoration()
      : super(
            gradient: LinearGradient(colors: [
              ProductColors.instance.mainRed,
              ProductColors.instance.seconRed
            ]),
            borderRadius: const ProductBorderRadius.lTileContainerBRadius(),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(5, 8),
              ),
            ],
            border: Border.all(
              color: Colors.white38,
              width: 2,
            ));

  ProductBoxDecoration.patientContainerBDecoration(BuildContext context)
      : super(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(5, 8),
              ),
            ],
            border: Border.all(
              color: ProductColors.instance.mainRed,
              width: 2,
            ));
}
