import 'package:flutter/material.dart';
import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/widgets/viewmodel/custom_textfield_vm.dart';
import 'package:stacked/stacked.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      this.keyboardType,
      required this.controller,
      required this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CustomTextFieldVM(),
      builder: (context, vModel, child) {
        return TextFormField(
          maxLines: hintText == 'Description' ? 5 : 1,
          readOnly: hintText == 'Service' ? true : false,
          obscureText: hintText == 'Password' || hintText == 'Confirm Password'
              ? vModel.obscureText
              : false,
          keyboardType: keyboardType,
          controller: controller,
          style: Style.regular14ptb,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            suffixIcon: hintText == 'Password' || hintText == 'Confirm Password'
                ? InkWell(
                    onTap: () => vModel.toggleObscureText(),
                    child: Icon(
                      vModel.obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xff626262),
                    ),
                  )
                : null,
            hintStyle: Style.regular16ptb,
            fillColor: const Color(0xff626262).withOpacity(0.10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color(0xff626262).withOpacity(0.10),
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
                width: 3,
              ),
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}
