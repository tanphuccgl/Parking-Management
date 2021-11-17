import 'dart:convert';

import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:parking_management1/main.dart';

LoginData getCurrentUser() {
  final loginResponse = prefs?.getString(SAVE_LOGIN_RESPONSE);
  if (loginResponse != null && loginResponse != '') {
    var response = LoginData.fromJson(json.decode(loginResponse));

    return response;
  } else {
    throw CacheException();
  }
}
