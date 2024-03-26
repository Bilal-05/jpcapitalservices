import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/appointment_view/appointment_vm.dart';
import 'package:jp_app/views/appointment_view/widget/selected_item.dart';
import 'package:jp_app/widgets/custom_button.dart';
import 'package:jp_app/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class AppointmentView extends StatelessWidget {
  final String service;
  const AppointmentView({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AppointmentVM(),
      onViewModelReady: (viewModel) => viewModel.init(service),
      builder: (context, viewModel, child) => Scaffold(
        body: SizedBox(
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
                      'Appointment',
                      style: Style.bol30ptb,
                    ),
                  ),
                  0.01.sh.verticalSpace,
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        'Book yourself an appointment.',
                        style: Style.medium14ptb.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  0.05.sh.verticalSpace,
                  Center(
                    child: Container(
                      width: 0.3.sw,
                      height: 0.3.sw,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(viewModel.imageUrl),
                        ),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  0.01.sh.verticalSpace,
                  Center(
                    child: Text(
                      viewModel.service!,
                      style: Style.medium20ptb.copyWith(color: Colors.black),
                    ),
                  ),
                  0.03.sh.verticalSpace,
                  Center(
                    child: SizedBox(
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              child: CustomTextField(
                                controller: viewModel.nameController,
                                hintText: 'Name',
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            20.verticalSpace,
                            // SizedBox(
                            //   child: CustomTextField(
                            //     controller: viewModel.phoneController,
                            //     hintText: 'Phone Number',
                            //     keyboardType: TextInputType.text,
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return 'Enter your phone number';
                            //       } else {
                            //         return null;
                            //       }
                            //     },
                            //   ),
                            // ),
                            Container(
                              // margin: const EdgeInsets.only(left: 5),
                              height: 0.2.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.transparent, width: 3),
                                color:
                                    const Color(0xff626262).withOpacity(0.10),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: viewModel.phoneNumberField(),
                              ),
                            ),
                            20.verticalSpace,
                            SizedBox(
                              child: CustomTextField(
                                controller: viewModel.addressController,
                                hintText: 'Address',
                                keyboardType: TextInputType.streetAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your address';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            20.verticalSpace,
                            SizedBox(
                              child: CustomTextField(
                                controller: viewModel.descriptionController,
                                hintText: 'Description',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Describe your issue';
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
                  Column(
                    children: [
                      SizedBox(
                        width: 1.sw,
                        child: Row(
                          children: [
                            Text(
                              'Date',
                              style: Style.semiBold20ptb,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                viewModel.onTap(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    viewModel.selectedMonth!,
                                    style: Style.regular14ptb,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.primaryColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      SizedBox(
                        height: 0.15.sh,
                        child: DatePicker(
                          viewModel.initialDate,
                          daysCount: 31,
                          initialSelectedDate: viewModel.initialDate,
                          selectionColor: AppColors.primaryColor,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            // New date selected
                            viewModel.setDate(date);
                          },
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text(
                      "Select Time",
                      style: Style.medium14ptb,
                    ),
                  ),
                  20.verticalSpace,
                  DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: viewModel.timeIndex,
                    onSelectedItemChanged: (index) {
                      viewModel.setTime(index);
                    },
                    items: viewModel.buildTimingItem(),
                    child: MySelectionItem(
                      isForList: false,
                      title: viewModel.timing[viewModel.timeIndex],
                    ),
                  ),

                  // if (vModel.images.isEmpty)
                  //   InkWell(
                  //     onTap: () {
                  //       vModel.addPhoto();
                  //     },
                  //     child: CustomButton(
                  //         width: 160.w, height: 60.w, text: 'Add Photo'),
                  //   ),

                  // if (vModel.images.isNotEmpty)
                  //   Container(
                  //     margin: EdgeInsets.only(top: 0.02.sh),
                  //     height: 0.05.sh,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: vModel.images.length,
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           margin: EdgeInsets.only(right: 0.02.sw),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Container(
                  //                 width: 0.10.sw,
                  //                 margin: EdgeInsets.only(
                  //                     right: 0.02.sw, left: 0.02.sw),
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: FileImage(
                  //                       vModel.images[index],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               InkWell(
                  //                 onTap: () {
                  //                   vModel.removeAt(index);
                  //                 },
                  //                 child: Container(
                  //                   margin: EdgeInsets.only(
                  //                       right: 0.02.sw, left: 0.02.sw),
                  //                   child: const Icon(
                  //                     Icons.delete,
                  //                     color: Colors.red,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // 20.verticalSpace,
                  // if (vModel.images.isNotEmpty)
                  //   IconButton(
                  //     onPressed: () {
                  //       vModel.addPhoto();
                  //     },
                  //     icon: const Icon(Icons.attach_file),
                  //   ),
                  // // InkWell(
                  // //   onTap: () {
                  // //     vModel.addPhoto();
                  // //   },
                  // //   child: SizedBox(
                  // //     child: CustomButton(
                  // //       height: 60.w,
                  // //       width: 160.w,
                  // //       text: 'Add More',
                  // //     ),
                  // //   ),
                  // // ),

                  // // const Spacer(),
                  30.verticalSpace,
                  SizedBox(
                    child: InkWell(
                      onTap: () {
                        viewModel.navigateBackToMain();
                      },
                      child: CustomButton(
                        width: 320.w,
                        height: 60.h,
                        text: 'Submit',
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0.03.sh),
                      child: TextButton(
                        onPressed: () {
                          viewModel.navigateToEstimation();
                        },
                        child: Text(
                          'I haven\'t send any mail!.',
                          style: Style.medium14ptb,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
