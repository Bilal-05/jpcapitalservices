// Splash View UI in here

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/splash_view/splash_vm.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      onViewModelReady: (viewModel) => viewModel.initialize(),
      viewModelBuilder: () => SplashVM(),
      builder: (ctx, vModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      vModel.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'JP Capital Services',
                    style: Style.semiBold35ptb,
                  ),
                  20.verticalSpace,
                  SizedBox(
                    width: 0.90.sw,
                    child: Text(
                      'Explore the services we are providing and make your life easy.',
                      style: Style.regular16ptb.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
