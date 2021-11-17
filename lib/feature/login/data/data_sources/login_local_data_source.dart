import 'dart:convert';

import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<LoginData> getLogin();

  Future<void> saveLogin(LoginData loginData);
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginData> getLogin() {
    final jsonString = sharedPreferences.getString(SAVE_LOGIN_RESPONSE);
    if (jsonString != null && jsonString != '') {
      return Future.value(LoginData.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveLogin(LoginData loginData) {
    return sharedPreferences.setString(
        SAVE_LOGIN_RESPONSE, json.encode(loginData.toJson()));
  }
}
