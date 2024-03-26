// ignore_for_file: unused_local_variable
// ForgetPassword View Logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
import 'package:jp_app/services/button_style_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgetVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  ButtonStyleService buttonStyleService = ButtonStyleService();
  TextEditingController emailController = TextEditingController();
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();

  String forgot = 'assets/JSON/forget.json';

  resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );
        snackBarService.showSnackbar(
          message: 'Email sent successfully',
          title: 'Success',
          duration: const Duration(seconds: 1),
        );
        navigationService.replaceWithLoginView();
      } on FirebaseAuthException catch (e) {
        snackBarService.showSnackbar(
          message: e.message.toString(),
          title: 'Error',
          duration: const Duration(seconds: 1),
        );
        log(e.code);
      } catch (e) {
        // print(e);
      }
    } else {
      SnackbarService().showSnackbar(
        message: 'Please enter valid email',
        title: 'Error',
        duration: const Duration(seconds: 1),
      );
    }
  }
}
