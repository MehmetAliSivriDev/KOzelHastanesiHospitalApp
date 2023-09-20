import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';

class SimpleCustomTextFormField extends StatelessWidget {
  const SimpleCustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final String? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        validator: (value) => validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.txtFormFieldBRadius()),
        ));
  }
}
