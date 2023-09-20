import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
    required this.validator,
  });

  final TextEditingController emailController;
  final String? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator,
      textInputAction: TextInputAction.next,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.email),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: ProductBorderRadius.txtFormFieldBRadius())),
    );
  }
}
