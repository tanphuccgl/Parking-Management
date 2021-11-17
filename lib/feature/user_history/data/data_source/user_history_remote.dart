import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/error/exceptions.dart';
import 'package:parking_management1/feature/user_history/data/models/user_history_res.dart';

abstract class UserHistoryRemoteDataSource {
  Future<UserHistoryResponse> courseContents(int id);
}

class UserHistoryRemoteDataSourceImpl implements UserHistoryRemoteDataSource {
  final http.Client? client;

  UserHistoryRemoteDataSourceImpl({this.client});

  @override
  Future<UserHistoryResponse> courseContents(int id) {
    return _courseContents(id);
  }

  Future<UserHistoryResponse> _courseContents(int id) async {
    final response = await client?.get(
      Uri.parse(
          'http://149.28.129.166:3002/vehicle/LayDanhSachTrangThaiXe/${id}'),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json" // k co header la failed 415
        //'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    log("Get UserHistoryResponse: " +
        "http://149.28.129.166:3002/vehicle/LayDanhSachTrangThaiXe/${id}");
    log("Response Json UserHistoryResponse: ${json.decode(response!.body)}");

    if (response.statusCode == 200) {
      var success = UserHistoryResponse.fromJson(json.decode(response.body));

      return success;
    } else {
      throw ServerException();
    }
  }
}
