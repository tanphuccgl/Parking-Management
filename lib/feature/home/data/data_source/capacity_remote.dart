import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';

abstract class CapacityRemoteDataSource {
  Future<CapacityResponse> courseContents(String loaixe);
}

class CapacityRemoteDataSourceImpl implements CapacityRemoteDataSource {
  final http.Client? client;

  CapacityRemoteDataSourceImpl({this.client});

  @override
  Future<CapacityResponse> courseContents(String loaixe) {
    return _courseContents(loaixe);
  }

  Future<CapacityResponse> _courseContents(String loaixe) async {
    final response = await client?.get(
      Uri.parse(
          'http://149.28.129.166:3002/capacity/ShowInforCapacity?typeVehicle=${loaixe}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get CapacityResponse: " +
        "http://149.28.129.166:3002/capacity/ShowInforCapacity?typeVehicle=${loaixe}");
    log("Response Json CapacityResponse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = CapacityResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
