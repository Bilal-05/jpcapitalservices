import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/login_view/login_vm.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:jp_app/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LoginVM(),
      builder: (context, vModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 0.05.sw,
                  left: 0.05.sw,
                  top: 0.075.sh,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Login here',
                          style: Style.bol30ptb,
                        ),
                      ),
                      0.02.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            'Welcome back you\'ve been missed',
                            style:
                                Style.medium14ptb.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      0.05.sh.verticalSpace,
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
                                    controller: vModel.passwordController,
                                    hintText: 'Password',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter correct password';
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
                      0.02.sh.verticalSpace,
                      SizedBox(
                        child: InkWell(
                          onTap: () {
                            vModel.navigateToForgetPassword();
                          },
                          child: Text(
                            'Forgot your password?',
                            style: Style.semiBold16ptb,
                          ),
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      Center(
                        // child: SizedBox(
                        //   child: ElevatedButton(
                        //     style: vModel.buttonStyleService.buttonStyleLarge,
                        //     onPressed: () {
                        //       vModel.login();
                        //     },
                        //     child: Text(
                        //       'Sign in',
                        //       style: Style.semiBold20ptw,
                        //     ),
                        //   ),
                        // ),
                        child: InkWell(
                          onTap: () {
                            vModel.login();
                          },
                          child: CustomButton(
                            height: 60.h,
                            width: 320.w,
                            text: 'Login',
                          ),
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              vModel.navigateToRegister();
                            },
                            child: Text(
                              'Create an account',
                              style: Style.semiBold16ptb,
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
