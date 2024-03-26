// login View Logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
import 'package:jp_app/services/button_style_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final navigationService = locator<NavigationService>();
  final buttonStyleService = locator<ButtonStyleService>();
  final snackBarService = locator<SnackbarService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String google = 'assets/svg/google.svg';

  navigateToForgetPassword() {
    navigationService.navigateToForgetView();
  }

  navigateToRegister() {
    navigationService.replaceWithRegisterView();
  }

  clear() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  login() {
    if (formKey.currentState!.validate()) {
      snackBarService.showSnackbar(
        message: 'Logging in...',
        title: 'Wait',
        duration: const Duration(seconds: 2),
      );
      emailLogin();
    } else {
      snackBarService.showSnackbar(
        message: 'Please enter valid email and password',
        title: 'Error',
        duration: const Duration(seconds: 2),
      );
    }
  }

  isLoggedin(UserCredential credential) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    await prefs.setString('documentID', credential.user!.uid.toString());

    log(prefs.getString('documentID')!);
    log(prefs.getBool('isLogin').toString());
    notifyListeners();
  }

  emailLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoggedin(credential);
      Future.delayed(
        const Duration(milliseconds: 1500),
      );
      clear();
      navigationService.replaceWithMainMenuView();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        snackBarService.showSnackbar(
          message: 'Invalid Credentials.',
          title: 'Error',
          duration: const Duration(seconds: 1),
        );
      } else if (e.code == 'network-request-failed') {
        snackBarService.showSnackbar(
          message: 'Network timeout.',
          title: 'Error',
          duration: const Duration(seconds: 1),
        );
      }
      log(e.code);
    } catch (e) {
      log(e.toString());
    }
  }
}
