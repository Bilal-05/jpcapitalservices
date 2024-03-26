// estimation form view

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/estimation_view/estimation_vm.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:jp_app/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

class EstimationView extends StatelessWidget {
  final String serviceName;
  const EstimationView({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EstimationVM(),
      onViewModelReady: (viewModel) => viewModel.init(serviceName),
      builder: (context, vModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    right: 0.05.sw,
                    left: 0.05.sw,
                    top: 0.075.sh,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Estimation',
                          style: Style.bol30ptb,
                        ),
                      ),
                      0.01.sh.verticalSpace,
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: Text(
                            'Tell us your problem. We will tell you the estimated cost.',
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
                                    controller: vModel.serviceController,
                                    hintText: 'Service',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'No Service Selected';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                20.verticalSpace,
                                SizedBox(
                                  child: CustomTextField(
                                    controller: vModel.nameController,
                                    hintText: 'Name',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter name';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                20.verticalSpace,
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
                                    controller: vModel.descriptionController,
                                    hintText: 'Description',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Provide description';
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
                      20.verticalSpace,
                      if (vModel.images.isEmpty)
                        InkWell(
                          onTap: () {
                            vModel.addPhoto();
                          },
                          child: CustomButton(
                              width: 160.w, height: 60.w, text: 'Add Photo'),
                        ),

                      if (vModel.images.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 0.02.sh),
                          height: 0.05.sh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vModel.images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 0.02.sw),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 0.10.sw,
                                      margin: EdgeInsets.only(
                                          right: 0.02.sw, left: 0.02.sw),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                            vModel.images[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        vModel.removeAt(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 0.02.sw, left: 0.02.sw),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      20.verticalSpace,
                      if (vModel.images.isNotEmpty)
                        // IconButton(
                        //   onPressed: () {
                        //     vModel.addPhoto();
                        //   },
                        //   icon: const Icon(Icons.attach_file),
                        // ),
                        InkWell(
                          onTap: () {
                            vModel.addPhoto();
                          },
                          child: SizedBox(
                            child: Row(
                              children: [
                                const Icon(Icons.attach_file),
                                Text(
                                  'Add More',
                                  style: Style.regular14ptb
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // InkWell(
                      //   onTap: () {
                      //     vModel.addPhoto();
                      //   },
                      //   child: SizedBox(
                      //     child: CustomButton(
                      //       height: 60.w,
                      //       width: 160.w,
                      //       text: 'Add More',
                      //     ),
                      //   ),
                      // ),

                      // const Spacer(),
                      30.verticalSpace,
                      Container(
                        margin: EdgeInsets.only(bottom: 0.03.sh),
                        child: InkWell(
                          onTap: () {
                            vModel.navigateToAppointmentView();
                          },
                          child: CustomButton(
                            width: 320.w,
                            height: 60.h,
                            text: 'Submit',
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
