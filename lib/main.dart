import 'package:blood_donation/helper/notification_helper.dart';
import 'package:blood_donation/helper/router_helper.dart';
import 'package:blood_donation/provider/auth_provider.dart';
import 'package:blood_donation/provider/darah_provider.dart';
import 'package:blood_donation/provider/ketersediaan_provider.dart';
import 'package:blood_donation/provider/language_provider.dart';
import 'package:blood_donation/provider/localization_provider.dart';
import 'package:blood_donation/provider/notification_provider.dart';
import 'package:blood_donation/provider/pendaftaran_provider.dart';
import 'package:blood_donation/provider/permintaan_provider.dart';
import 'package:blood_donation/provider/theme_provider.dart';
import 'package:blood_donation/theme/dark_theme.dart';
import 'package:blood_donation/theme/light_theme.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<LocalizationProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<DarahProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<PendaftaranProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<PermintaanProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<NotificationProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<KetersediaanProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;
  String initalRoutes;

  @override
  void initState() {
    super.initState();
    RouterHelper.setupRouter();
    checking();
  }

  Future<void> checking() async {
    // melakukan pengecekan status login
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      // update fcm token ke database
      Provider.of<AuthProvider>(context, listen: false).updateToken();
      setState(() {
        initalRoutes = Routes.HOME_SCREEN;
      });
    } else {
      setState(() {
        initalRoutes = Routes.STARTUP_SCREEN;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: initalRoutes,
          onGenerateRoute: RouterHelper.router.generator,
          title: 'Glucose Monitoring',
          navigatorKey: MyApp.navigatorKey,
          theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: _locals,
        );
      },
    );
  }
}
