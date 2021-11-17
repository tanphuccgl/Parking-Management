import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';

abstract class UserGetVahicleRemoteDataSource {
  Future<UserGetVahicleResponse> courseContents(int id);
}

class UserGetVahicleRemoteDataSourceImpl
    implements UserGetVahicleRemoteDataSource {
  final http.Client? client;

  UserGetVahicleRemoteDataSourceImpl({this.client});

  @override
  Future<UserGetVahicleResponse> courseContents(int id) {
    return _courseContents(id);
  }

  Future<UserGetVahicleResponse> _courseContents(int id) async {
    final response = await client!.get(
      Uri.parse('http://149.28.129.166:3002/vehicle/GetXeCuaChuXe/${id}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get UserGetVahicleResponse: " +
        'http://149.28.129.166:3002/vehicle/GetXeCuaChuXe/${id}');
    log("Response Json UserGetVahicleResponse: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      var success = UserGetVahicleResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
