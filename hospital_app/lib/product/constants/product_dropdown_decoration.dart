import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';

class ProducDropDownDecoration extends InputDecoration {
  const ProducDropDownDecoration.appointmentDropDownDecoration()
      : super(
          border: const OutlineInputBorder(
            borderRadius: ProductBorderRadius.dropdownBRadius(),
          ),
        );
}
