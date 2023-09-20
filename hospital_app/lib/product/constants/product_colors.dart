import 'package:flutter/material.dart';

class ProductColors {
  static ProductColors? _instance;
  static ProductColors get instance {
    _instance ??= ProductColors._init();
    return _instance!;
  }

  ProductColors._init();

  final Color mainRed = const Color(0xffdc3545);
  final Color seconRed = const Color(0xff870000);
  final Color customBlue = const Color(0xff0d6efd);
  final Color successGreen = const Color(0xff198754);
}
