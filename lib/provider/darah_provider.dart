import 'dart:convert';

import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/model/response/darah_model.dart';
import 'package:blood_donation/data/repository/darah_repo.dart';
import 'package:flutter/widgets.dart';

class DarahProvider extends ChangeNotifier {
  final DarahRepo darahRepo;

  DarahProvider({@required this.darahRepo});

  bool _isLoading;
  List<DarahModel> _darahList;

  bool get isLoading => _isLoading;
  List<DarahModel> get darahList => _darahList;

  Future<void> getDarah() async {
    _isLoading = true;
    ApiResponse apiResponse = await darahRepo.getDarah();
    _darahList = [];
    if (apiResponse.response.statusCode == 200) {
      final jsonData = apiResponse.response.data;
      bool success = jsonData['success'];

      if (success) {
        List data = jsonDecode(jsonEncode(jsonData['data']));

        _darahList = data
            .map((darah) => DarahModel.fromJson(darah as Map<String, dynamic>))
            .toList();
      }
      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
  }
}
