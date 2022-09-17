import 'package:blood_donation/data/datasource/remote/dio/dio_client.dart';
import 'package:blood_donation/data/datasource/remote/exception/api_error_handler.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class KetersediaanRepo {
  final DioClient dioClient;

  KetersediaanRepo({@required this.dioClient});

  Future<ApiResponse> getKetersediaan(int idDarah) async {
    try {
      final response = await dioClient.get(
        AppConstants.KETERSEDIAAN_URI,
        queryParameters: {'id_darah': idDarah},
      );

      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
