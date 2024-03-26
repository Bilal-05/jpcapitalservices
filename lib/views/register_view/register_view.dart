// register view UI in here

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/register_view/register_vm.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:jp_app/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => RegisterVM(),
      builder: (context, vModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: InkWell(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                margin: EdgeInsets.only(
                  right: 0.05.sw,
                  left: 0.05.sw,
                  top: 0.075.sh,
                ),
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Create Account',
                          style: Style.bol30ptb,
                        ),
                      ),
                      0.01.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: Text(
                            'Create your account here.',
                            style:
                                Style.medium14ptb.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      0.06.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          child: Form(
                            key: vModel.formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: CustomTextField(
                                    controller: vModel.emailController,
                                    hintText: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value!);

                                      if (value.isEmpty || !emailValid) {
                                        return 'Enter correct email';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                20.verticalSpace,
                                SizedBox(
                                  child: CustomTextField(
                                    controller: vModel.passController,
                                    hintText: 'Password',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      bool validPass = RegExp(
                                              "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@\$!%*#?&])[A-Za-z\\d@\$!%*#?&]{8,}\$")
                                          .hasMatch(value!);
                                      if (value.isEmpty || !validPass) {
                                        return 'Minimum eight characters and must be unique.';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                20.verticalSpace,
                                SizedBox(
                                  child: CustomTextField(
                                    controller: vModel.passConfirmController,
                                    hintText: 'Confirm Password',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value != vModel.passController.text) {
                                        return 'Password does\'nt match.';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      Center(
                        child: InkWell(
                          onTap: () {
                            vModel.register();
                          },
                          child: CustomButton(
                            height: 60.h,
                            width: 320.w,
                            text: 'Register',
                          ),
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              vModel.navigateToLogin();
                            },
                            child: Text(
                              'Already have an account',
                              style: Style.semiBold16ptb.copyWith(
                                color: const Color(0xff494949),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
