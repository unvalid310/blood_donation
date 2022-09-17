import 'package:blood_donation/view/screens/ketersediaan/ketersediaan_screen.dart';
import 'package:blood_donation/view/screens/pendaftaran/pendaftaran_screen.dart';
import 'package:blood_donation/view/screens/permintaan/permintaan_screen.dart';
import 'package:blood_donation/view/screens/syarat/syarat_screen.dart';
import 'package:blood_donation/view/screens/notification/notification_screen.dart';
import 'package:blood_donation/view/screens/startup/startup_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/view/screens/auth/login_screen.dart';
import 'package:blood_donation/view/screens/auth/register_screen.dart';
import 'package:blood_donation/view/screens/home/home_screen.dart';
import 'package:blood_donation/view/screens/profile/profile_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _startupHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => StartupScreen());
  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => RegisterScreen());
  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => LoginScreen());
  static Handler _homeHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  static Handler _syaratHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => SyaratScreen());
  static Handler _pendaftaranHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          PendaftaranScreen());
  static Handler _permintaanHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          PermintaanScreen());
  static Handler _ketersediaanHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          KetersediaanScreen());
  static Handler _profileHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => ProfileScreen());
  static Handler _notificationHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          NotificationScreen());

  static void setupRouter() {
    router.define(Routes.STARTUP_SCREEN,
        handler: _startupHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.REGISTER_SCREEN,
        handler: _registerHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.inFromRight);
    router.define(Routes.HOME_SCREEN,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.SYARAT_SCREEN,
        handler: _syaratHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PENDAFTARAN_SCREEN,
        handler: _pendaftaranHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PERMINTAAN_SCREEN,
        handler: _permintaanHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.KETERSEDIAAN_SCREEN,
        handler: _ketersediaanHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PROFILE_SCREEN,
        handler: _profileHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.NOTIFICATION_SCREEN,
        handler: _notificationHandler, transitionType: TransitionType.fadeIn);
  }
}
