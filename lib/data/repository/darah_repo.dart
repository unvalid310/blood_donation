import 'package:blood_donation/data/datasource/remote/dio/dio_client.dart';
import 'package:blood_donation/data/datasource/remote/exception/api_error_handler.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:flutter/foundation.dart';

class DarahRepo {
  final DioClient dioClient;

  DarahRepo({@required this.dioClient});

  Future<ApiResponse> getDarah() async {
    try {
      final response = await dioClient.get(AppConstants.DARAH_URI);
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
