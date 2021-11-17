import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';

abstract class TimeAllRemoteDataSource {
  Future<TimeAllResponse> courseContents(String loaixe);
}

class TimeAllRemoteDataSourceImpl implements TimeAllRemoteDataSource {
  final http.Client? client;

  TimeAllRemoteDataSourceImpl({this.client});

  @override
  Future<TimeAllResponse> courseContents(String loaixe) {
    return _courseContents(loaixe);
  }

  Future<TimeAllResponse> _courseContents(String loaixe) async {
    final response = await client?.get(
      Uri.parse(
          'http://149.28.129.166:3002/vehicle/GetTimeCheckInCheckOut?keySearchLicensePlate=${loaixe}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get TimeAll: " +
        "http://149.28.129.166:3002/vehicle/GetTimeCheckInCheckOut?keySearchLicensePlate=${loaixe}");
    log("Response Json TimeAll: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = TimeAllResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
