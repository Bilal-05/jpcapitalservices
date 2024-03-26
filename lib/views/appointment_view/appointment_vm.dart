// Appointment View logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
// import 'package:jp_app/services/google_service.dart';
import 'package:jp_app/services/service.dart';
import 'package:jp_app/views/appointment_view/widget/selected_item.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AppointmentVM extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  DateTime initialDate = DateTime.now();
  DateTime? selectedDate;
  String? selectedMonth;
  int monthNumber = DateTime.now().month;

  int timeIndex = 0;

  final timing = [
    "7am - 10am",
    "11am - 2pm",
    "3pm - 6pm",
    "7pm-10pm",
  ];

  setMonth() {
    switch (monthNumber) {
      case 1:
        selectedMonth = 'January';
      case 2:
        selectedMonth = 'Februray';
      case 3:
        selectedMonth = 'March';
      case 4:
        selectedMonth = 'April';
      case 5:
        selectedMonth = 'May';
      case 6:
        selectedMonth = 'June';
      case 7:
        selectedMonth = 'July';
      case 8:
        selectedMonth = 'August';
      case 9:
        selectedMonth = 'September';
      case 10:
        selectedMonth = 'October';
      case 11:
        selectedMonth = 'November';
      case 12:
        selectedMonth = 'December';
      default:
        selectedMonth = 'Error';
    }
  }

  resetMonth() {
    switch (initialDate.month) {
      case 1:
        selectedMonth = 'January';
      case 2:
        selectedMonth = 'Februray';
      case 3:
        selectedMonth = 'March';
      case 4:
        selectedMonth = 'April';
      case 5:
        selectedMonth = 'May';
      case 6:
        selectedMonth = 'June';
      case 7:
        selectedMonth = 'July';
      case 8:
        selectedMonth = 'August';
      case 9:
        selectedMonth = 'September';
      case 10:
        selectedMonth = 'October';
      case 11:
        selectedMonth = 'November';
      case 12:
        selectedMonth = 'December';
      default:
        selectedMonth = 'Error';
    }
  }

  List<Widget> buildTimingItem() {
    return timing
        .map((val) => MySelectionItem(
              title: val,
              isForList: true,
            ))
        .toList();
  }

  setTime(value) {
    timeIndex = value;
    notifyListeners();
  }

  final services = Services();
  String imageUrl = '';
  String? service;

  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool correctNumber = false;
  String numberText = '';

  setDate(date) {
    selectedDate = date;
    log(selectedDate.toString());
    notifyListeners();
  }

  onTap(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      initialDate = pickedDate;
      resetMonth();
      log(selectedMonth!);
      log(DateTime.now().toString());
      log(initialDate.toString());
      notifyListeners();
    } else {}
  }

  Widget phoneNumberField() {
    return InternationalPhoneNumberInput(
      inputDecoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      onInputChanged: (PhoneNumber number) {
        log(number.phoneNumber.toString());
        numberText = number.phoneNumber.toString();
        notifyListeners();
      },
      onInputValidated: (bool value) {
        if (!value) {
          log('Invalid Number');
        } else {
          log(value.toString());
          correctNumber = true;
          notifyListeners();
        }
      },
      hintText: '3XX-XXXXXXX',
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: phoneController,
      formatInput: true,
      keyboardType: TextInputType.phone,
      inputBorder: const OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        log('On Saved: $number');
      },
      onFieldSubmitted: (value) {
        log(value);
        log(phoneController.text);
      },
      errorMessage: 'Invalid phone number',
    );
  }

  init(serviceName) {
    service = serviceName;
    for (int i = 0; i < services.service.length; i++) {
      if (services.service[i]['serviceName'] == service) {
        imageUrl = services.service[i]['icon'];
        notifyListeners();
      }
    }
    setMonth();
    log(selectedMonth!);
    log(service!);
    log(imageUrl);
    notifyListeners();
  }

  // openDialog() {
  //   dialogService
  //       .showConfirmationDialog(
  //     title: 'Go Back baby',
  //     description: 'Go Back',
  //     cancelTitle: 'No',
  //     confirmationTitle: 'Yes',
  //   )
  //       .then(
  //     (value) {
  //       if (value!.confirmed) {
  //         setFalse();
  //         log('erased');
  //         navigationService.replaceWithMainMenuView();
  //       } else {
  //         log('not erased');
  //       }
  //     },
  //   );
  // }

  navigateBackToMain() async {
    if (formKey.currentState!.validate()) {
      await sendEmail();
      // sendEmail();
      await setFalse();
      navigationService.replaceWithMainMenuView();
    } else {
      SnackbarService().showSnackbar(
          message: 'Fill all fields',
          title: 'Error',
          duration: const Duration(seconds: 1));
    }
  }

  setFalse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final serviceList = prefs.getStringList('service') ?? [];
    await prefs.setStringList('service', serviceList..remove(service!));
    log(prefs.getStringList('service').toString());
    log('erased');
  }

  Future<void> sendEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    final Email email = Email(
      body:
          'Hey JP, \n\nMy name is ${nameController.text}. \n\nI want to book an appointment for ${service!} on ${DateFormat('dd-MM-yyyy').format(selectedDate!)}. \n\nTiming will be ${timing[timeIndex]}. \n\nAdress:\n${addressController.text}. \n\nDescription:\n${descriptionController.text} \n\nMy phone number is ${phoneController.text} \n\nRegards, \n${nameController.text} \n${user!.email}',
      subject: '${service!} required',
      recipients: ["mamudrama@gmail.com"],
      // attachmentPaths: attachments,
      // isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      // print(error);
      platformResponse = error.toString();
      SnackbarService().showSnackbar(
        message: error.toString(),
        title: 'Error',
        duration: const Duration(seconds: 1),
      );
      log(error.toString());
    }

    SnackbarService().showSnackbar(
      message: platformResponse,
      title: 'Success',
      duration: const Duration(seconds: 1),
    );
  }

  navigateToEstimation() {
    setFalse();
    navigationService.replaceWithEstimationView(serviceName: service!);
  }

  // Future onSubmit() async {
  //   log('in');

  //   final user = await GoogleAuthApi.signIn();

  //   if (user == null) return log('user is null');

  //   final email = user.email;
  //   final auth = await user.authentication;
  //   final token = auth.accessToken;

  //   log('middle');

  //   final smtpServer = gmailSaslXoauth2(email, token!);
  //   final messageEmail = Message()
  //     ..from = Address(email, nameController.text.toString())
  //     ..recipients.add(const Address('mamudrama@gmail.com'))
  //     // ..ccRecipients
  //     //     .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  //     // ..bccRecipients.add('bccAddress@example.com')
  //     ..subject = '${service!} required'
  //     ..text =
  //         'Hey JP, \n\nMy name is ${nameController.text}. \n\nI want to book an appointment for ${service!} on ${DateFormat('dd-MM-yyyy').format(selectedDate!)}. \n\nTiming will be ${timing[timeIndex]}. \n\nAdress:\n${addressController.text}. \n\nDescription:\n${descriptionController.text} \n\nMy phone number is ${phoneController.text} \n\nRegards, \n${nameController.text} \n${user.email}';
  //   // ..html =
  //   //     '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
  //   // ..attachments = [
  //   //   FileAttachment(
  //   //     File(images[0].path),
  //   //   )
  //   //     ..location = Location.inline
  //   //     ..cid = '<myimg@3.141>',
  //   // ];

  //   try {
  //     await send(messageEmail, smtpServer);
  //     SnackbarService().showSnackbar(
  //       message: 'Email sent successfully',
  //       title: 'Success',
  //       duration: const Duration(seconds: 1),
  //     );
  //   } on MailerException catch (e) {
  //     log(e.toString());
  //   }
  //   log('ended');
  // }
}
