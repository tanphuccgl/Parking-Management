import 'package:flutter/material.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/data_source/dk_account_remote.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_page.dart';

class DangKyAccountPage extends StatefulWidget {
  static const String routeName = "/DangKyAccountPage";
  DangKyAccountPage({Key? key}) : super(key: key);

  @override
  _DangKyAccountPageState createState() => _DangKyAccountPageState();
}

class _DangKyAccountPageState extends State<DangKyAccountPage> {
  final fullName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  String? fullName1;
  String? username1;
  String? password1;
  String gioitinh = "Male";
  int gender = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text("Register an account"),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            color: Colors.black87,
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.width / 25,
                    left: size.width / 18,
                    right: size.width / 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            controller: fullName,
                            onChanged: (value) {
                              fullName1 = value;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(size.width / 24),
                              hintText: "Full name",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.width / 15),
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
                            controller: username,
                            onChanged: (value) {
                              username1 = value;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(size.width / 24),
                              hintText: "Username ",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.width / 15),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amberAccent),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(size.width / 24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: size.width / 60,
                              offset: Offset(0, size.width / 180),
                            ),
                          ],
                        ),
                        height: 60,
                        child: TextField(
                            controller: password,
                            onChanged: (value) {
                              password1 = value;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(size.width / 24),
                              hintText: "Password ",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent),
                      ),
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return Container(
                        width: size.width - 40,
                        height: 60,
                        child: InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 49),
                                  borderRadius: BorderRadius.circular(20))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              menuMaxHeight: 250,
                              isExpanded: true,
                              alignment: AlignmentDirectional.center,
                              dropdownColor: Colors.black,
                              value: gioitinh,
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                              ),
                              iconSize: 24,
                              elevation: 30,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  gioitinh = newValue!;
                                });

                                print("aaa  ${gioitinh}");
                              },
                              items: <String>[
                                "Male",
                                "Female"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("${value}"),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: button(() {
                        if (gioitinh == "Male") {
                          gender = 1;
                        } else if (gioitinh == "Female") {
                          gender = 0;
                        }
                        dangkytaikhoan(
                            gender: gender,
                            fullName: fullName1,
                            password: password1,
                            username: username1,
                            function: () {
                              showOk();
                            },
                            function2: () {
                              showCancel();
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
      description: "Successful account registration",
      onPressed: () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListUserPage()));
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
      description: "Account registration failed",
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
