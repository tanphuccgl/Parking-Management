import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_page.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/data_source/dk_account_remote.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_bloc.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_event.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_state.dart';

class DangkixePage extends StatefulWidget {
  static const String routeName = "/DangkixePage";
  DangkixePage({Key? key}) : super(key: key);

  @override
  _DangkixePageState createState() => _DangkixePageState();
}

class _DangkixePageState extends State<DangkixePage> {
  final typeVehicle = TextEditingController();
  final licensePlate = TextEditingController();
  String? typeVehicle1;
  String? licensePlate1;
  int? b = 1;

  String loaixe = "Xe máy";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            elevation: 0,
            title: Text("Vehicle registration"),
          ),
          body: BlocProvider(
              create: (_) => sl<ProductBloc>(),
              child: BlocBuilder<ProductBloc, UserState>(
                  builder: (context, state) {
                if (state is Empty) {
                  BlocProvider.of<ProductBloc>(context).add(GetUserE());
                } else if (state is Loading) {
                  return SpinkitLoading();
                } else if (state is Loaded) {
                  String? _a = state.swagger!.data![0].fullName;
                  return SingleChildScrollView(
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
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Full Name",
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: size.width - 40,
                              height: 60,
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              size.width / 24),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 50))),
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        menuMaxHeight: 300,
                                        isExpanded: true,
                                        dropdownColor: Colors.black,
                                        alignment: AlignmentDirectional.center,
                                        value: _a,
                                        icon: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                        ),
                                        iconSize: 24,
                                        elevation: 30,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _a = newValue!;
                                          });
                                          for (var f in state.swagger!.data!) {
                                            if (_a == f.fullName) {
                                              b = f.iId;
                                            }
                                          }
                                          print("aaa  ${_a}");
                                          print("bbbb  ${b}");
                                        },
                                        items: state.swagger!.data!
                                            .map<DropdownMenuItem<String>>(
                                                (Data value) {
                                          return DropdownMenuItem<String>(
                                            value: value.fullName,
                                            child: Text("${value.fullName}"),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  })),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Text(
                                "License plates",
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size.width / 15),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.circular(size.width / 24),
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
                                      contentPadding:
                                          EdgeInsets.all(size.width / 24),
                                      hintText: "Enter license plate number",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "Vehicle type",
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            StatefulBuilder(builder: (context, setState) {
                              return Container(
                                width: size.width - 40,
                                height: 60,
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(size.width / 24),
                                  )),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      menuMaxHeight: 250,
                                      isExpanded: true,
                                      value: loaixe,
                                      dropdownColor: Colors.black,
                                      alignment: AlignmentDirectional.center,
                                      icon: const Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                      ),
                                      iconSize: 24,
                                      elevation: 30,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          loaixe = newValue!;
                                        });

                                        print("aaa  ${loaixe}");
                                      },
                                      items: <String>["Xe máy", "Xe ô tô"]
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
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
                              padding: EdgeInsets.only(top: size.height / 5.5),
                              child: button(
                                () {
                                  dangkyxe(
                                      employeeId: b,
                                      licensePlate: licensePlate1,
                                      typeVehicle: loaixe,
                                      function: () {
                                        showOk();
                                      },
                                      function2: () {
                                        showCancel();
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is Error) {
                  return Text("tam thoi khong hoat dong");
                }
                return Container();
              }))),
    );
  }

  Widget input(TextEditingController? controller1, Function(String)? function1,
      TextEditingController? controller2, Function(String)? function2) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.black12,
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
              controller: controller1,
              onChanged: function1,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(size.width / 24),
                hintText: "Phone, email or username",
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontFamily: 'OpenSans',
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.width / 20),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.black12,
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
                controller: controller2,
                onChanged: function2,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(size.width / 24),
                  hintText: "Password",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,
                      color: Colors.white12),
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.width / 20),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.black12,
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
                controller: controller2,
                onChanged: function2,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(size.width / 24),
                  hintText: "Password",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,
                      color: Colors.white12),
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'OpenSans',
                  ),
                )),
          ),
        )
      ],
    );
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
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }

  void showOk() {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Vehicle registration successful",
      onPressed: () {
        setState(() {
          Navigator.pop(context);

          Navigator.pop(context);

          Navigator.pop(context);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CarListPage()));
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
      description: "Vehicle registration failed",
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
}
