import 'dart:convert';

import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/model/response/permintaan_model.dart';
import 'package:blood_donation/data/model/response/response_model.dart';
import 'package:flutter/foundation.dart';

import 'package:blood_donation/data/repository/permintaan_repo.dart';

class PermintaanProvider extends ChangeNotifier {
  final PermintaanRepo permintaanRepo;
  PermintaanProvider({@required this.permintaanRepo});

  bool _isLoading = false;
  bool _statusPermintaan = false;
  String _messagePermintaan = '';
  List<PermintaanModel> _permintaanList = [];
  PermintaanModel _permintaanModel;

  bool get isLoading => _isLoading;
  bool get statusPermintaan => _statusPermintaan;
  String get messagePermintaan => _messagePermintaan;
  List<PermintaanModel> get permintaanList => _permintaanList;
  PermintaanModel get permintaanModel => _permintaanModel;

  Future<void> getPermintaan() async {
    _isLoading = true;
    _statusPermintaan = false;
    _messagePermintaan = '';
    _permintaanList = [];

    ApiResponse apiResponse = await permintaanRepo.getPermintaan();

    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      bool status = data['success'];

      if (status) {
        _statusPermintaan = data['data']['status_permintaan'];
        _messagePermintaan = data['data']['message_permintaan'];
        final jsonData = data['data']['permintaan'];

        List permintaanData = jsonDecode(jsonEncode(jsonData));

        _permintaanList = permintaanData
            .map((darah) =>
                PermintaanModel.fromJson(darah as Map<String, dynamic>))
            .toList();
      }

      _isLoading = false;
    }

    notifyListeners();
  }

  Future<ResponseModel> createPermintaan(Map<String, dynamic> data) async {
    _isLoading = true;
    ResponseModel responseModel;

    ApiResponse apiResponse = await permintaanRepo.createPermintaan(data);

    if (apiResponse.response.statusCode == 200) {
      final data = apiResponse.response.data;
      responseModel = ResponseModel(data['success'], data['message']);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(false, 'Terjadi kesalahan');
    }

    notifyListeners();
    return responseModel;
  }

  Future<void> getDetailPermintaan(int id) async {
    _isLoading = true;
    ApiResponse apiResponse = await permintaanRepo.getDetailPermintaan(id);

    if (apiResponse.response.statusCode == 200) {
      bool status = apiResponse.response.data['success'];
      if (status)
        _permintaanModel = PermintaanModel.fromJson(
            apiResponse.response.data['data'] as Map<String, dynamic>);
      _isLoading = false;
    }

    print('Nama OS >> ${_permintaanModel.id}');
    notifyListeners();
  }
}
