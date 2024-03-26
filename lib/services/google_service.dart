import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    // if (await _googleSignIn.isSignedIn()) {
    //   log('hai user');
    //   // log(_googleSignIn.currentUser!.email);
    //   return _googleSignIn.currentUser;
    // } else {
    log('nhin hai');
    return await _googleSignIn.signIn();
    // }
  }

  static Future signOut() => _googleSignIn.signOut();
}
