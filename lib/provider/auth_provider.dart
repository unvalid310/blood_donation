import 'package:flutter/foundation.dart';
import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/model/response/response_model.dart';
import 'package:blood_donation/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(Map<String, dynamic> data) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await authRepo.registration(data);
    if (apiResponse.response.data['success']) {
      Map<String, dynamic> data = apiResponse.response.data['data'];
      await authRepo.saveUserData(idUser: int.parse(data['id']));
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.login(email, password);
    ResponseModel responseModel;
    if (apiResponse.response.data['success']) {
      Map<String, dynamic> data = apiResponse.response.data['data'];
      await authRepo.saveUserData(
        idUser: int.parse(data['id']),
        email: data['email'],
        username: data['username'],
        password: data['password'],
      );
      if (apiResponse.response.data['success']) {
        await authRepo.updateToken();
      }
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<void> updateToken() async {
    ApiResponse apiResponse = await authRepo.updateToken();
    print('updadate token >> ${apiResponse.response.statusCode}');
    if (apiResponse.response.statusCode == 200) {
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print('update token message >> $errorMessage');
    }
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> logout() async {
    bool status = false;
    status = await authRepo.clearSharedData().then((value) {
      return value;
    });
    return status;
  }
}
