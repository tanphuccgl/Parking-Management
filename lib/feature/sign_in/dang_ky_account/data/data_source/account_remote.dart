import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

abstract class GetUserRemoteDataSource {
  Future<GetUser> getProduct();
}

class GetUserRemoteDataSourceImpl implements GetUserRemoteDataSource {
  final http.Client? client;

  GetUserRemoteDataSourceImpl({this.client});

  @override
  Future<GetUser> getProduct() {
    // TODO: implement getAttendanceHistories
    return _getFromUrl();
  }

  Future<GetUser> _getFromUrl() async {
    final response = await client!.get(
        Uri.parse('http://149.28.129.166:3002/account/GetEmployee'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",

          // k co header la failed 415
        });
    log("Post Get GetEmployee:" +
        "http://149.28.129.166:3002/account/GetEmployee");
    print(response.statusCode);
    // log("Response Json GetEmployee: ${json.decode(response.body)}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = GetUser.fromJson(json.decode(response.body));
      return result;
    } else {
      throw ServerException();
    }
  }
}
