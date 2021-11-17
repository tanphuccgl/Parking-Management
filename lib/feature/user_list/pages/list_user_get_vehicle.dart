import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/core/config/components/alert_dialog2.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyaccount_page.dart';
import 'package:parking_management1/feature/user_list/data/data_source/remove_user.dart';
import 'package:parking_management1/feature/user_list/data/data_source/reset_pw_user.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_bloc.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_page.dart';
import 'package:parking_management1/feature/user_list/widgets/body_user_get_vehicle.dart';

class ListUserGetVehiclePage extends StatefulWidget {
  final int? id;
  final String? name;
  final String? account;

  static const String routeName = "/ListUserGetVehiclePage";
  ListUserGetVehiclePage({Key? key, this.id, this.name, this.account})
      : super(key: key);

  @override
  _ListUserGetVehiclePageState createState() => _ListUserGetVehiclePageState();
}

class _ListUserGetVehiclePageState extends State<ListUserGetVehiclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.restart_alt_outlined),
            onPressed: () {
              AlertDialog2.yesAbortDialog(
                  context: context,
                  title: "RESET",
                  body:
                      "Do you want to reset the password of ${widget.account} account?",
                  onPressed: () {
                    resetPw(
                        id: widget.id,
                        function: () {
                          showOk1();
                        },
                        function2: () {
                          showCancel1();
                        });
                    //   Navigator.pushNamedAndRemoveUntil(context, PageRoutes.onBoardingPage,(Route<dynamic> route) => false);
                  });

              //   Navigator.pushNamedAndRemoveUntil(context, PageRoutes.onBoardingPage,(Route<dynamic> route) => false);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => DangKyAccountPage()));
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.highlight_remove_outlined),
            onPressed: () {
              AlertDialog2.yesAbortDialog(
                  context: context,
                  title: "DELETE",
                  body: "Do you want to delete ${widget.account} account?",
                  onPressed: () {
                    removeUser(
                        id: widget.id,
                        function: () {
                          showOk();
                        },
                        function2: () {
                          showCancel();
                        });
                    //   Navigator.pushNamedAndRemoveUntil(context, PageRoutes.onBoardingPage,(Route<dynamic> route) => false);
                  });
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => DangKyAccountPage()));
            },
          )
        ],
        backgroundColor: Colors.transparent,
        title: Text("${widget.name}"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<UserGetVahicleBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserGetVahicleBloc>(),
        child: SingleChildScrollView(
            child: BodyUserGetVehicle(
          id: widget.id,
        )));
  }

  void showOk() {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Account deleted successfully",
      onPressed: () {
        setState(() {
          Navigator.pop(context);
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
      description: "Failed account deletion",
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void showOk1() {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Password reset successful",
      onPressed: () {
        setState(() {
          Navigator.pop(context);
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

  void showCancel1() {
    var alert = new AlertDialog1(
      title: "ERROR",
      description: "Password reset failed",
      onPressed: () {
        Navigator.pop(context);
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
