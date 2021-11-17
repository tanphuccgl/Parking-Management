import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/login/presentations/manager/login_bloc.dart';
import 'package:parking_management1/feature/login/presentations/widgets/body_login.dart';

class LoginPage extends StatelessWidget {
  BuildContext? bcontext;
  static const String routeName = "/LoginPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        child: buildBody(context),
      ),
    ));
  }

  BlocProvider<LoginBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<LoginBloc>(),
        child: SingleChildScrollView(child: BodyLogin()));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: bcontext!,
          builder: (context) => new AlertDialog(
            title: new Text('Quit?'),
            content: new Text('Do you really want logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
