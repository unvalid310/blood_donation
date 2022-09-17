import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/model/response/response_model.dart';
import 'package:blood_donation/data/repository/pendaftaran_repo.dart';
import 'package:flutter/widgets.dart';

class PendaftaranProvider extends ChangeNotifier {
  final PendaftaranRepo pendaftaranRepo;

  PendaftaranProvider({@required this.pendaftaranRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> createPendaftaran(Map<String, dynamic> data) async {
    _isLoading = true;

    ResponseModel responseModel;
    ApiResponse apiResponse = await pendaftaranRepo.createPendaftaran(data);
    if (apiResponse.response.statusCode == 200) {
      final responseData = apiResponse.response.data;
      bool success = responseData['success'];
      String message = responseData['message'];

      responseModel = ResponseModel(success, message);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(false, 'Terjadi kesalahan');
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }
}
