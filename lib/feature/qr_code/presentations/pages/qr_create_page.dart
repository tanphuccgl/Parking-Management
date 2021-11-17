import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreatePage extends StatefulWidget {
  static const String routeName = "/QrCreatePage";
  QrCreatePage({Key? key}) : super(key: key);

  @override
  _QrCreatePageState createState() => _QrCreatePageState();
}

class _QrCreatePageState extends State<QrCreatePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // QrImage(
              //   data: "fijasdhfjk",
              //   version: QrVersions.auto,
              //   size: 200.0,
              // ),

              Image.memory(Uri.parse(
                      "data:image/png;base64,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")
                  .data!
                  .contentAsBytes()),
            ],
          ),
        ),
      ),
    );
  }
}
