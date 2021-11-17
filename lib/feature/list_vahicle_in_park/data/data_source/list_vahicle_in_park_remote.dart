import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/models/list_vahicle_in_park_res.dart';

abstract class ListVahicleInParkRemoteDataSource {
  Future<ListVahicleInParkResponse> courseContents(String loaixe, String name);
}

class ListVahicleInParkRemoteDataSourceImpl
    implements ListVahicleInParkRemoteDataSource {
  final http.Client? client;

  ListVahicleInParkRemoteDataSourceImpl({this.client});

  @override
  Future<ListVahicleInParkResponse> courseContents(String loaixe, String name) {
    return _courseContents(loaixe, name);
  }

  Future<ListVahicleInParkResponse> _courseContents(
      String loaixe, String name) async {
    final response = await client?.get(
      Uri.parse(
          'http://149.28.129.166:3002/vehicle/GetVehicleInParking?${name}typeVehicle=${loaixe}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get ListVahicleInParkResponse: " +
        "http://149.28.129.166:3002/vehicle/GetVehicleInParking?${name}typeVehicle=${loaixe}");
    log("Response Json ListVahicleInParkResponse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success =
          ListVahicleInParkResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
