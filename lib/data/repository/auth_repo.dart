import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/data/datasource/remote/dio/dio_client.dart';
import 'package:blood_donation/data/datasource/remote/exception/api_error_handler.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> registration(Map<String, dynamic> data) async {
    try {
      Response response = await dioClient
          .post(
            AppConstants.REGISTER_URI,
            data: data,
          )
          .timeout(const Duration(seconds: 10));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(
          ApiErrorHandler.getMessage('Terjadi kesalahan'));
    }
  }

  Future<void> saveUserData(
      {@required int idUser,
      String email,
      String username,
      String password}) async {
    try {
      sharedPreferences.setString(AppConstants.ID_USER, idUser.toString());
      sharedPreferences.setString(AppConstants.EMAIL, email);
      sharedPreferences.setString(AppConstants.USERNAME, username);
      sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {}
  }

  Future<ApiResponse> login(String email, String password) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: FormData.fromMap({
          "email": email,
          "password": password,
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken;

      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      _deviceToken = await _saveDeviceToken();

      print(
          'user ID >> ${sharedPreferences.getString(AppConstants.ID_USER)} token $_deviceToken');
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {
          "user_id": sharedPreferences.getString(AppConstants.ID_USER),
          "token": _deviceToken.toString()
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = await FirebaseMessaging.instance.getToken();
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.EMAIL);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.clear();
    return true;
  }
}
