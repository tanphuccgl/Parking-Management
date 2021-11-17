import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/qr_code/data/data_source/check_out_remote.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPage extends StatefulWidget {
  static const String routeName = "/QrScanPage";
  QrScanPage({Key? key}) : super(key: key);

  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  var txt = TextEditingController();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      bottomNavigationBar: CustomBottomNavigationBar(
        index: 1,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      // if (result != null)
                      //   checkOut(qrCode: result!.code) == true
                      //       ? TextField(
                      //           enabled: false,
                      //           controller: txt,
                      //           onChanged: (value) {
                      //             fullName1 = value;
                      //           },
                      //           style: TextStyle(color: Colors.white),
                      //           decoration: InputDecoration(
                      //             focusedBorder: InputBorder.none,
                      //             enabledBorder: InputBorder.none,
                      //             errorBorder: InputBorder.none,
                      //             disabledBorder: InputBorder.none,
                      //             contentPadding:
                      //                 EdgeInsets.all(size.width / 24),
                      //             hintText: "Scan a code",
                      //             hintStyle: TextStyle(
                      //               color: Colors.white,
                      //               fontFamily: 'OpenSans',
                      //             ),
                      //           ))
                      //       // Text(
                      //       //     "Successful scan",
                      //       //     style: TextStyle(
                      //       //         color: Colors.amberAccent,
                      //       //         fontSize: 20,
                      //       //         fontWeight: FontWeight.bold),
                      //       //   )
                      //       : Text(
                      //           "Invalid QR code",
                      //           style: TextStyle(
                      //               color: Colors.amberAccent,
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.bold),
                      //         )
                      // //         )
                      // else
                      //   SnackBar(
                      //     content: Text('Scan a code'),
                      //     elevation: 15,
                      //     behavior: SnackBarBehavior.floating,
                      //     action: SnackBarAction(
                      //       label: 'UNDO',
                      //       onPressed: () {},
                      //     ),
                      //   )
                    ],
                  ),
                  // if (result != null && checkOut(qrCode: result!.code) == true)
                  //   Text(
                  //     "Successful scan",
                  //     style: TextStyle(
                  //         color: Colors.amberAccent,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),
                  //   )
                  // else if (result != null)
                  //   Text(
                  //     'Scan a code',
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),
                  //   )
                  // else if (result != null &&
                  //     checkOut(qrCode: result!.code) == false)
                  //   Text(
                  //     "Invalid QR code",
                  //     style: TextStyle(
                  //         color: Colors.amberAccent,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),
                  //   ),

                  // Text(
                  //     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return snapshot.data == true
                                    ? Text('Flash: On',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))
                                    : Text('Flash: Off',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold));
                              },
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold));
                                } else {
                                  return Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: Text('pause', style: TextStyle(fontSize: 20)),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: Text('resume', style: TextStyle(fontSize: 20)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
  ) {
    bool a = false;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData;
        if (result != null && a == false) {
          a = true;
          await checkOut(
              qrCode: result!.code,
              function: () async {
                await controller.pauseCamera();
                showOk(controller);
              },
              function2: () {
                controller.pauseCamera();
                showCancel(controller);
              });
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showOk(QRViewController controller) {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Check Out Successfully",
      onPressed: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrScanPage()));
          controller.resumeCamera();
        });
      },
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alert;
        });
  }

  void showCancel(QRViewController controller) {
    var alert = new AlertDialog1(
      title: "ERROR",
      description: "Invalid QR code",
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QrScanPage()));
        controller.resumeCamera();
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
