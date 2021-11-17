import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginData> login(String email, String pass);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client? client;

  LoginRemoteDataSourceImpl({@required this.client});

  @override
  Future<LoginData> login(String email, String pass) {
    return _login(email, pass);
  }

  Future<LoginData> _login(String email, String pass) async {
    var body = jsonEncode({'username': email, 'password': pass});
    final response = await client
        ?.post(Uri.parse('${mainUrl}/account/Login'),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json" // k co header la failed 415
              //'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: body)
        .timeout(Duration(seconds: 15));
    log("Post Login: " + '${mainUrl}/account/Login');
    log("Post body Login: " + body);
    log("Response Json Login: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = LoginResponseModel.fromJson(json.decode(response.body));

      return success.data!;
    } else {
      throw ServerException();
    }
  }
}
