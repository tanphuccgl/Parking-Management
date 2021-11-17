import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/config/get_current_user.dart';
import 'package:parking_management1/core/error/exceptions.dart';

http.Client client = http.Client();

Future<bool> dangkytaikhoan(
    {String? fullName,
    String? username,
    String? password,
    int? gender,
    Function? function,
    Function? function2}) async {
  var body = jsonEncode({
    'fullName': fullName,
    'username': username,
    'password': password,
    'gender': gender,
  });
  final response = await client.post(
    Uri.parse('http://149.28.129.166:3002/account/Register'),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'auth-token': '${getCurrentUser().token}',
      // k co header la failed 415
    },
    body: body,
  );
  log("Put dangkytaikhoan:" + "http://149.28.129.166:3002/account/Register");
  log("Body put dangkytaikhoan" + body);
  log("Response Put dangkytaikhoan: ${response.statusCode}");
  if (response.statusCode == 200 || response.statusCode == 201) {
    function!();
    return true;
  } else {
    function2!();
    throw ServerException();
  }
}

Future<bool> dangkyxe(
    {int? employeeId,
    String? typeVehicle,
    String? licensePlate,
    Function? function,
    Function? function2}) async {
  var body = jsonEncode({
    'employeeId': employeeId,
    'typeVehicle': typeVehicle,
    'licensePlate': licensePlate,
  });

  final response = await client.post(
    Uri.parse('http://149.28.129.166:3002/vehicle/DangKyXe/${employeeId}'),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'auth-token': '${getCurrentUser().token}',
      // k co header la failed 415
    },
    body: body,
  );
  log("Put dangkyxe:" +
      "http://149.28.129.166:3002/vehicle/DangKyXe/${employeeId}");

  log("Body put dangkyxe" + body);
  log("Response Put dangkyxe: ${response.statusCode}");
  log("Response Json dangkyxe: ${json.decode(response.body)}");
  if (response.statusCode == 200 || response.statusCode == 201) {
    function!();
    return true;
  } else {
    function2!();

    throw ServerException();
  }
}
