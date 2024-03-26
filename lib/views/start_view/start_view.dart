// Startup View UI in here

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/colors.dart';
// import 'package:jp_app/app/app.router.dart';
// import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/start_view/start_vm.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:svg_flutter/svg.dart';
// import 'package:svg_flutter/svg.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StartVM(),
      builder: (ctx, vModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                right: 0.02.sw,
                left: 0.02.sw,
                top: 0.02.sh,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0.75.sw,
                      child: Image.asset(
                        vModel.personLaptop,
                        fit: BoxFit.cover,
                      ),
                    ),
                    0.05.sh.verticalSpace,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 0.90.sw,
                          child: Text(
                            'Get your desired job done',
                            softWrap: true,
                            style: Style.semiBold35ptb,
                            textAlign: TextAlign.center,
                            strutStyle: const StrutStyle(height: -1.5),
                          ),
                        ),
                        30.verticalSpace,
                        SizedBox(
                          width: 0.75.sw,
                          child: Text(
                            'Explore the services we are providing and make your life easy.',
                            style: Style.regular16ptb
                                .copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.01.sh),
                        child: InkWell(
                          onTap: () {
                            vModel.navigateToLogin();
                          },
                          child: CustomButton(
                            width: 320.w,
                            height: 60.h,
                            text: 'Login',
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.03.sh),
                        child: ElevatedButton.icon(
                          style: vModel.buttonStyle.googleButton,
                          onPressed: () {
                            // vModel.navigateToRegister();
                            vModel.signInWithGoogle();
                            // vModel.navigationService.replaceWithMainMenuView();
                          },
                          icon: vModel.isBusy
                              ? Container()
                              : SvgPicture.asset(
                                  vModel.google,
                                  width: 24.w,
                                ),
                          label: vModel.isBusy
                              ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : Text(
                                  'Contiune with google',
                                  style: Style.semiBold14ptb,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
