// Splash View Logic in here

import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/views/mainmenu_view/mainmenu_view.dart';
import 'package:jp_app/views/start_view/start_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashVM extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  String logo = 'assets/images/Logo.png';
  bool isLogin = false;

  checkIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? isLogin;
    notifyListeners();
  }

  fetchData() async {
    await checkIsLogin();
  }

  initialize() async {
    await fetchData();
    await Future.delayed(const Duration(seconds: 3));
    navigateToView();
  }

  navigateToView() {
    if (isLogin) {
      navigationService.replaceWithTransition(
        const MainMenuView(),
        // transition: 'fade',
        duration: const Duration(milliseconds: 500),
      );
    } else {
      navigationService.replaceWithTransition(
        const StartView(),
        // transition: 'fade',
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
