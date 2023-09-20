import 'package:flutter/material.dart';
import 'package:hospital_app/features/login/view/login_view.dart';
import 'package:hospital_app/product/constants/product_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme:
              ColorScheme.dark(primary: ProductColors.instance.mainRed),
          useMaterial3: true),
      home: LoginView(),
    );
  }
}
