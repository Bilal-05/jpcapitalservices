import 'package:flutter/material.dart';

class AppColors {
  static Color secondaryColor = const Color(0xFFFBE487);
  static Color primaryColor = const Color(0xffA67D46);
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [Color(0xFFFBE487), Color(0xffA67D46), Color(0xFFFBE487)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.clamp,
  );
}
