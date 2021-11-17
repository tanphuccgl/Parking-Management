import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/config/get_current_user.dart';
import 'package:parking_management1/core/error/exceptions.dart';

http.Client client = http.Client();
Future<bool> checkIn(
    {String? licensePlate,
    Function? function,
    Function? function2,
    Function? function3}) async {
  var body = jsonEncode({
    'licensePlate': licensePlate,
  });

  final response = await client.post(
    Uri.parse('http://149.28.129.166:3002/vehicle/CheckInXeVaoBai'),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'auth-token': '${getCurrentUser().token}',
      // k co header la failed 415
    },
    body: body,
  );
  log("Put dangkyxe:" + "http://149.28.129.166:3002/vehicle/CheckInXeVaoBai");

  log("Body put checkIn" + body);
  log("Response Put checkIn: ${response.statusCode}");
  log("Response Json checkIn: ${json.decode(response.body)}");
  if (response.statusCode == 200 || response.statusCode == 201) {
    function!();
    return true;
  } else if (response.statusCode == 402) {
    function3!();
    return false;
  } else {
    function2!();
    throw ServerException();
  }
}
