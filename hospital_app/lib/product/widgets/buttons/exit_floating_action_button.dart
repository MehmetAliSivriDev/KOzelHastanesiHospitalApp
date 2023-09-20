import 'package:flutter/material.dart';
import 'package:hospital_app/features/login/view/login_view.dart';
import 'package:kartal/kartal.dart';

class ExitFloatingActionButton extends StatelessWidget {
  const ExitFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
            (route) => false, // Tüm geçmişi temizle
          );
        },
        icon: const Icon(
          Icons.exit_to_app_rounded,
          color: Colors.white,
        ),
        label: Text(
          "Çıkış Yap",
          style: context.general.textTheme.titleMedium,
        ));
  }
}
