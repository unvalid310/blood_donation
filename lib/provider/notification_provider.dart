import 'dart:convert';

import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/model/response/notification_model.dart';
import 'package:blood_donation/data/repository/notification_repo.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;

  NotificationProvider({@required this.notificationRepo});

  bool _isLoading;
  List<NotificationModel> _notificationList;

  bool get isLoading => _isLoading;
  List<NotificationModel> get notificationList => _notificationList;

  Future<void> getNotification() async {
    _isLoading = true;
    _notificationList = [];

    ApiResponse apiResponse = await notificationRepo.getNotification();
    print('notification response >> ${apiResponse.response.data['data']}');

    if (apiResponse.response.statusCode == 200) {
      List data = jsonDecode(jsonEncode(apiResponse.response.data['data']));
      bool status = apiResponse.response.data['success'];
      if (status) {
        _notificationList =
            data.map((value) => NotificationModel.fromJson(value)).toList();
      }
      _isLoading = false;
    }

    notifyListeners();
  }
}
