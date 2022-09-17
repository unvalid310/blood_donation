import 'package:blood_donation/data/model/response/language_model.dart';

class AppConstants {
  static const String BASE_URL = 'https://blooddonation.diabetbuddy.com/api/';

  static const String REGISTER_URI = 'auth/register';
  static const String LOGIN_URI = 'auth/login';
  static const String DARAH_URI = 'darah';
  static const String PENDAFTARAN_URI = 'pendaftaran';
  static const String PERMINTAAN_URI = 'permintaan';
  static const String KETERSEDIAAN_URI = 'ketersediaan';
  static const String NOTIFICATION_URI = 'notification';
  static const String TOKEN_URI = 'auth/update_token';

  // Shared Key
  static const String ID_USER = 'id_user';
  static const String EMAIL = 'email';
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String TOPIC = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'Indonesian', countryCode: 'ID', languageCode: 'id'),
  ];
}
