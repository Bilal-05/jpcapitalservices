// Register View Logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
import 'package:jp_app/services/button_style_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterVM extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final buttonStyleService = locator<ButtonStyleService>();

  final formKey = GlobalKey<FormState>();
  final snackbarService = locator<SnackbarService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

  clear() {
    emailController.clear();
    passController.clear();
    passConfirmController.clear();
    notifyListeners();
  }

  register() {
    if (formKey.currentState!.validate()) {
      snackbarService.showSnackbar(
        message: 'Registering...',
        title: 'Wait',
        duration: const Duration(seconds: 4),
      );
      registerUser();
      // navigationService.replaceWithLoginView();
    } else {
      snackbarService.showSnackbar(
        message: 'Please enter valid email and password',
        title: 'Error',
        duration: const Duration(seconds: 2),
      );
    }
  }

  registerUser() async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      clear();
      snackbarService.showSnackbar(
        message: 'Account created successfully',
        title: 'Success',
        duration: const Duration(seconds: 1),
      );
      navigateToLogin();
      navigationService.replaceWithLoginView();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackbarService.showSnackbar(
          message: 'The password provided is too weak.',
          title: 'Error',
          duration: const Duration(seconds: 1),
        );
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        snackbarService.showSnackbar(
          message: 'The account already exists for that email.',
          title: 'Error',
          duration: const Duration(seconds: 2),
        );
        log('The account already exists for that email.');
      }
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
  }

  navigateToLogin() {
    navigationService.replaceWithLoginView();
  }
}
