import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';

abstract class TimeCheckInRemoteDataSource {
  Future<TimeCheckInResponse> getListTeacher();
}

class TimeCheckInRemoteDataSourceImpl implements TimeCheckInRemoteDataSource {
  final http.Client? client;

  TimeCheckInRemoteDataSourceImpl({@required this.client});

  @override
  Future<TimeCheckInResponse> getListTeacher() {
    return _getListTeacher();
  }

  Future<TimeCheckInResponse> _getListTeacher() async {
    final response = await client?.get(
      Uri.parse('http://149.28.129.166:3002/vehicle/GetTimeCheckIn'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    log("Get TimeCheckInResponse: " +
        "http://149.28.129.166:3002/vehicle/GetTimeCheckIn");
    log("Response Json TimeCheckInResponse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = TimeCheckInResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
