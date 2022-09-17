import 'package:blood_donation/data/datasource/remote/dio/dio_client.dart';
import 'package:blood_donation/data/datasource/remote/exception/api_error_handler.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermintaanRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  PermintaanRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getPermintaan() async {
    try {
      final response = await dioClient.get(
        AppConstants.PERMINTAAN_URI,
        queryParameters: {
          "user_id": sharedPreferences.getString(
            AppConstants.ID_USER,
          ),
        },
      );

      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  Future<ApiResponse> createPermintaan(Map<String, dynamic> data) async {
    try {
      data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

      final response = await dioClient.post(
        AppConstants.PERMINTAAN_URI,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  Future<ApiResponse> getDetailPermintaan(int idPermintaan) async {
    try {
      final response = await dioClient.get(
        '${AppConstants.PERMINTAAN_URI}/detail',
        queryParameters: {
          "id_permintaan": idPermintaan,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
