import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_durations.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
    required this.validator,
  });

  final TextEditingController passwordController;
  final String? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isSecure = true;
  final String _obscureText = "*";
  final String _hintText = "Şifre";
  void _changeSecure() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => widget.validator,
      obscureText: _isSecure,
      obscuringCharacter: _obscureText,
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
          suffix: _suffixVisibleButton(),
          hintText: _hintText,
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.txtFormFieldBRadius())),
    );
  }

  Widget _suffixVisibleButton() {
    return InkWell(
      onTap: () {
        _changeSecure();
      },
      child: AnimatedCrossFade(
          firstChild: const Icon(Icons.visibility),
          secondChild: const Icon(Icons.visibility_off),
          crossFadeState:
              _isSecure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: ProductDurations.passTxtFieldDuration),
    );
  }
}
