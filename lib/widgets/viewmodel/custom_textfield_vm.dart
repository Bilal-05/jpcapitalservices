import 'package:stacked/stacked.dart';

class CustomTextFieldVM extends BaseViewModel {
  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
