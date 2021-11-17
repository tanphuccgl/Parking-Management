import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/time/time_check_out/data/models/time_check_out_res.dart';

abstract class TimeCheckOutRemoteDataSource {
  Future<TimeCheckOutResponse> getListTeacher();
}

class TimeCheckOutRemoteDataSourceImpl implements TimeCheckOutRemoteDataSource {
  final http.Client? client;

  TimeCheckOutRemoteDataSourceImpl({@required this.client});

  @override
  Future<TimeCheckOutResponse> getListTeacher() {
    return _getListTeacher();
  }

  Future<TimeCheckOutResponse> _getListTeacher() async {
    final response = await client?.get(
      Uri.parse('http://149.28.129.166:3002/vehicle/GetTimeCheckOut'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    log("Get TimeCheckOutResponse: " +
        "http://149.28.129.166:3002/vehicle/GetTimeCheckOut");
    log("Response Json TimeCheckOutResponse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = TimeCheckOutResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
