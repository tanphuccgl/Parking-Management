import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/feature/vahicle/data/models/vahicle_response_model.dart';

abstract class VahicleRemoteDataSource {
  Future<VahicleResponse> getProduct(String licensePlate);
}

class VahicleRemoteDataSourceImpl implements VahicleRemoteDataSource {
  final http.Client? client;

  VahicleRemoteDataSourceImpl({this.client});

  @override
  Future<VahicleResponse> getProduct(String licensePlate) {
    // TODO: implement getAttendanceHistories
    return _getFromUrl(licensePlate);
  }

  Future<VahicleResponse> _getFromUrl(String licensePlate) async {
    final response = await client?.get(
      Uri.parse(
          'http://149.28.129.166:3002/vehicle/GetThongTinXe?licensePlate=${licensePlate}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",

        // k co header la failed 415
      },
    );
    log("Post Get GetEmployee:" +
        "http://149.28.129.166:3002/vehicle/GetThongTinXe?licensePlate=${licensePlate}");
    print(response!.statusCode);
    // log("Response Json GetEmployee: ${json.decode(response.body)}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = VahicleResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerException();
    }
  }
}
