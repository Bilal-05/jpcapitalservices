import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/forget_view/forget_vm.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:jp_app/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class ForgetView extends StatelessWidget {
  const ForgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => ForgetVM(),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Forget Password',
                        style: Style.bol30ptb,
                      ),
                      SizedBox(
                        width: 0.75.sw,
                        child: Text(
                          'Reset your password here.',
                          style:
                              Style.medium14ptb.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      SizedBox(
                        width: 0.75.sw,
                        child: Center(
                          child: Lottie.asset(
                            vModel.forgot,
                            width: 0.65.sw,
                          ),
                        ),
                      ),
                      0.03.sh.verticalSpace,
                      SizedBox(
                        child: Form(
                          key: vModel.formKey,
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
                      ),
                      20.verticalSpace,
                      SizedBox(
                        width: 0.75.sw,
                        child: Text(
                          'Receive an email to reset your password.',
                          style:
                              Style.medium14ptb.copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 0.03.sh),
                        child: InkWell(
                          onTap: () {
                            vModel.resetPassword();
                          },
                          child: CustomButton(
                            height: 60.h,
                            width: 320.w,
                            text: 'Send Email',
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
