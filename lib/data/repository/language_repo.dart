import 'package:flutter/material.dart';
import 'package:blood_donation/data/model/response/language_model.dart';
import 'package:blood_donation/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
