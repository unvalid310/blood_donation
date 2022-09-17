import 'package:blood_donation/data/datasource/remote/dio/dio_client.dart';
import 'package:blood_donation/data/datasource/remote/exception/api_error_handler.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo(
      {@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getNotification() async {
    try {
      final response = await dioClient.get(
        AppConstants.NOTIFICATION_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
