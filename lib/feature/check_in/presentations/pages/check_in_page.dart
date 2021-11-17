import 'package:flutter/material.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/feature/check_in/data/data_source/check_in_remote.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';

class CheckInPage extends StatefulWidget {
  static const String routeName = "/CheckInPage";
  CheckInPage({Key? key}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final licensePlate = TextEditingController();

  String? licensePlate1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text("Check In"),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        index: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            color: Colors.black87,
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.width / 10,
                    left: size.width / 18,
                    right: size.width / 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "License Plate",
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.width / 25),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amberAccent),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(size.width / 24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: size.width / 60,
                              offset: Offset(0, size.width / 180),
                            ),
                          ],
                        ),
                        height: 60,
                        child: TextField(
                            controller: licensePlate,
                            onChanged: (value) {
                              licensePlate1 = value;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(size.width / 24),
                              hintText: "Enter License Plate",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 250),
                      child: button(() {
                        checkIn(
                            licensePlate: licensePlate1,
                            function: () {
                              showOk();
                            },
                            function2: () {
                              showCancel();
                            },
                            function3: () {
                              showError();
                            });
                      }),
                    ),
                  ],
                ))),
      ),
    );
  }

  void showOk() {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Checkin Successfully",
      onPressed: () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckInPage()));
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

  void showCancel() {
    var alert = new AlertDialog1(
      title: "ERROR",
      description: "This car is already in the parking lot",
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void showError() {
    var alert = new AlertDialog1(
      title: "ERROR",
      description: "No license plate found",
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  Widget button(Function()? function) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width / 6,
      child: TextButton(
        onPressed: function,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(size.width / 17)),
            backgroundColor: Colors.white),
        child: Text("CONFIRM",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
