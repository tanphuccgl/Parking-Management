import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/config/get_current_user.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:parking_management1/feature/login/presentations/manager/login_bloc.dart';
import 'package:parking_management1/feature/login/presentations/manager/login_event.dart';
import 'package:parking_management1/feature/login/presentations/manager/login_state.dart';
import 'package:parking_management1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String? _email;
  String? _pass;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is Empty) {
        isLogin();
      } else if (state is LoginAlready) {
        appUser = getCurrentUser();
        inHome();
      } else if (state is Loaded) {
        LoginData lr;
        String string;
        string = prefs!.getString(SAVE_LOGIN_RESPONSE)!;

        appUser = state.data;
        lr = LoginData.fromJson(json.decode(string));
        appUser = lr;
        if (lr.role == "employee" || lr.role == "admin") {
          if (lr.role == "admin") {
            if (prefs!.getString(SAVE_ADMIN_RESPONSE) != null)
              appUser = LoginData.fromJson(
                  jsonDecode(prefs!.getString(SAVE_ADMIN_RESPONSE)!));
          } else if (lr.role == "employee") {
            if (prefs!.getString(SAVE_EMPLOYEE_RESPONSE) != null)
              appUser = LoginData.fromJson(
                  jsonDecode(prefs!.getString(SAVE_EMPLOYEE_RESPONSE)!));
            print("appTeacherr ${appUser!.fullName} ");
          }
        }

        inHome();
      } else if (state is Loading) {
        return SpinkitLoading();
      } else if (state is Error) {
        return Container(
          color: Colors.black87,
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.width / 18,
                left: size.width / 18,
                right: size.width / 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.width / 15),
                  child: title(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 7),
                  child: input(
                    _emailController,
                    (value) {
                      clear;
                      _email = value;
                    },
                    _passController,
                    (value) {
                      clear;
                      _pass = value;
                    },
                  ),
                ),
                _failed(),
                Padding(
                  padding: EdgeInsets.only(top: size.height / 3.5),
                  child: button(
                    () {
                      if (_email != null && _pass != null) {
                        return login();
                      } else {
                        return clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is NotLogin) {
        return Container(
          color: Colors.black87,
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.width / 18,
                left: size.width / 18,
                right: size.width / 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.width / 15),
                  child: title(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 7),
                  child: input(
                    _emailController,
                    (value) {
                      clear;
                      _email = value;
                    },
                    _passController,
                    (value) {
                      clear;
                      _pass = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height / 3),
                  child: button(
                    () {
                      if (_email != null && _pass != null) {
                        return login();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: Text('Please complete all information'),
                        ));
                        return clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container();
    });
  }

  void inHome() {
    Future.delayed(Duration.zero, () async {
      Navigator.pushNamedAndRemoveUntil(
          context, PageRoutes.homePage, (Route<dynamic> route) => false);
    });
  }

  void login() {
    BlocProvider.of<LoginBloc>(context).add(LoginE(_email!, _pass!));
  }

  void isLogin() {
    BlocProvider.of<LoginBloc>(context).add(IsLogin());
  }

  void clear() {
    BlocProvider.of<LoginBloc>(context).add(ClearE());
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
        )
      ],
    );
  }

  Widget title() {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's sign you in.",
          style: TextStyle(
              fontSize: size.width / 10,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        Text(
          "Welcome back.",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: size.width / 12),
        ),
        Text(
          "You've been missed!",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: size.width / 12),
        ),
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
        child: Text("Sign In",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }
}

Widget _failed() {
  return Container(
    child: Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Login failed. Email or password does not match!",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ))
      ],
    ),
  );
}
