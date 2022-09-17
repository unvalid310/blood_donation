import 'package:blood_donation/data/repository/darah_repo.dart';
import 'package:blood_donation/data/repository/ketersediaan_repo.dart';
import 'package:blood_donation/data/repository/notification_repo.dart';
import 'package:blood_donation/data/repository/pendaftaran_repo.dart';
import 'package:blood_donation/data/repository/permintaan_repo.dart';
import 'package:blood_donation/provider/darah_provider.dart';
import 'package:blood_donation/provider/ketersediaan_provider.dart';
import 'package:blood_donation/provider/notification_provider.dart';
import 'package:blood_donation/provider/pendaftaran_provider.dart';
import 'package:blood_donation/provider/permintaan_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:blood_donation/data/repository/auth_repo.dart';
import 'package:blood_donation/data/repository/language_repo.dart';
import 'package:blood_donation/provider/auth_provider.dart';
import 'package:blood_donation/provider/language_provider.dart';
import 'package:blood_donation/provider/localization_provider.dart';
import 'package:blood_donation/provider/theme_provider.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());

  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DarahRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => PendaftaranRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => PermintaanRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => NotificationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => KetersediaanRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => DarahProvider(darahRepo: sl()));
  sl.registerFactory(() => PendaftaranProvider(pendaftaranRepo: sl()));
  sl.registerFactory(() => PermintaanProvider(permintaanRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => KetersediaanProvider(ketersediaanRepo: sl()));
}
