// Startup View Logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
import 'package:jp_app/services/button_style_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartVM extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  ButtonStyleService buttonStyle = locator<ButtonStyleService>();

  String google = 'assets/svg/google.svg';

  String personLaptop = 'assets/images/personLaptop.png';

  navigateToLogin() {
    log('Login');
    navigationService.navigateToLoginView();
  }

  navigateViaGoogle() async {
    setBusy(true);
    signInWithGoogle();
    setBusy(false);
    // navigationService.navigateToMainMenuView();
  }

  isLoggedin(credential) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    await prefs.setString('documentID', credential.toString());
    await prefs.setStringList('service', ['services']);

    log(prefs.getString('documentID').toString());
    log(prefs.getBool('isLogin').toString());
    notifyListeners();
  }

  signInWithGoogle() async {
    setBusy(true);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    log("IdToken: ${credential.idToken.toString()}");
    log("AccessToken: ${credential.accessToken.toString()}");
    log("ProviderId: ${credential.providerId.toString()}");

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    isLoggedin(credential.idToken);
    setBusy(false);
    navigationService.replaceWithMainMenuView();
  }
}
