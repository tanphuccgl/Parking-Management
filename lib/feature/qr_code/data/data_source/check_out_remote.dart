import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:parking_management1/core/config/get_current_user.dart';
import 'package:parking_management1/core/error/exceptions.dart';

http.Client client = http.Client();
Future<bool> checkOut({
  String? qrCode,
  Function? function,
  Function? function2,
}) async {
  var body = jsonEncode({
    'qrCode': qrCode,
  });

  final response = await client.post(
    Uri.parse('http://149.28.129.166:3002/vehicle/CheckOutXeTrongBai'),
    headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'auth-token': '${getCurrentUser().token}',
      // k co header la failed 415
    },
    body: body,
  );
  log("Put checkOut:" +
      "http://149.28.129.166:3002/vehicle/CheckOutXeTrongBai");

  log("Body put checkOut" + body);
  log("Response Put checkOut: ${response.statusCode}");
  log("Response Json checkOut: ${json.decode(response.body)}");
  if (response.statusCode == 200 || response.statusCode == 201) {
    function!();
    return true;
  } else if (response.statusCode == 400) {
    function2!();
    return false;
  } else if (response.statusCode == 500) {
    //function2!();
    return false;
  } else {
    throw ServerException();
  }
}
