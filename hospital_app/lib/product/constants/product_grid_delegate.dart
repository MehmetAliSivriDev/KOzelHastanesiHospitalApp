import 'package:flutter/material.dart';

class ProductGridDelegate {
  ProductGridDelegate._init();

  static ProductGridDelegate get instance => ProductGridDelegate._init();

  final SliverGridDelegateWithFixedCrossAxisCount pfqwPolyclinics =
      const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 6 / 7,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2);
}
