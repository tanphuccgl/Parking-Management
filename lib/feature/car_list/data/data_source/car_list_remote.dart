import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';

abstract class VahicleListRemoteDataSource {
  Future<VahicleListResponse> courseContents(String loaixe, String name);
}

class VahicleListRemoteDataSourceImpl implements VahicleListRemoteDataSource {
  final http.Client? client;

  VahicleListRemoteDataSourceImpl({this.client});

  @override
  Future<VahicleListResponse> courseContents(String loaixe, String name) {
    return _courseContents(loaixe, name);
  }

  Future<VahicleListResponse> _courseContents(
      String loaixe, String name) async {
    final response = await client!.get(
      Uri.parse(
          'http://149.28.129.166:3002/Vehicle/GetDanhSachXe?${name}idTypeVehicle=${loaixe}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get VahicleListResponse: " +
        "http://149.28.129.166:3002/Vehicle/GetDanhSachXe?idTypeVehicle=${loaixe}");
    log("Response Json VahicleListResponse: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      var success = VahicleListResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
