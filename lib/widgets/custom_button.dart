import 'package:flutter/material.dart';
import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Center(
        child: Text(text, style: Style.semiBold20ptw),
      ),
    );
  }
}
