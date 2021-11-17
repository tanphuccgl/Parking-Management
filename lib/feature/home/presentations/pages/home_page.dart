import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_bloc.dart';
import 'package:parking_management1/feature/home/presentations/widgets/body_home.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar_user.dart';
import 'package:parking_management1/main.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SingleChildScrollView(
            child: BodyHome(),
          ),
        ),
        bottomNavigationBar: appUser?.role == "admin"
            ? CustomBottomNavigationBar(
                index: 0,
              )
            : CustomBottomNavigationBarUser(
                index: 0,
              )

        // ),
        );
  }

  BlocProvider<CapacityBloc> buildBody(BuildContext context) {
    return BlocProvider(create: (_) => sl<CapacityBloc>(), child: (BodyHome()));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Quit?'),
            content: new Text('Do you really want logout?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text('Yes'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
