import 'package:jp_app/services/button_style_service.dart';
import 'package:jp_app/services/google_service.dart';
import 'package:jp_app/services/service.dart';
import 'package:jp_app/views/appointment_view/appointment_view.dart';
import 'package:jp_app/views/estimation_view/estimation_view.dart';
import 'package:jp_app/views/forget_view/forget_view.dart';
import 'package:jp_app/views/login_view/login_view.dart';
import 'package:jp_app/views/mainmenu_view/mainmenu_view.dart';
import 'package:jp_app/views/register_view/register_view.dart';
import 'package:jp_app/views/splash_view/splash_view.dart';
import 'package:jp_app/views/start_view/start_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: StartView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ForgetView),
    MaterialRoute(page: MainMenuView),
    MaterialRoute(page: EstimationView),
    MaterialRoute(page: AppointmentView)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: ButtonStyleService),
    Singleton(classType: DialogService),
    Singleton(classType: SnackbarService),
    LazySingleton(classType: Services),
    LazySingleton(classType: GoogleAuthApi),
  ],
)
class App {}
