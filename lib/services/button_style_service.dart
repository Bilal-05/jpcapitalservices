import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/colors.dart';

class ButtonStyleService {
  var buttonStyleSmall = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    fixedSize: const Size(160, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  var buttonStyleSmall2 = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    fixedSize: const Size(160, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    side: BorderSide(color: AppColors.primaryColor, width: 1),
  );

  var buttonStyleLarge = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    fixedSize: const Size(360, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  var googleButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xffECECEC),
    fixedSize: Size(320.w, 60.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
