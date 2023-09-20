import 'package:flutter/material.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:kartal/kartal.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    required void Function() onPressed,
    Key? key,
  })  : _onPressed = onPressed,
        super(key: key);

  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
            onPressed: () {
              _onPressed();
            },
            child: Row(
              children: [
                Text(
                  ProductStrings.instance.appointmentContinueBText,
                  style: context.general.textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            )),
      ],
    );
  }
}
