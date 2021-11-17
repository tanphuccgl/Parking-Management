import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_bloc.dart';
import 'package:parking_management1/feature/car_list/presentations/widgets/body_car_list_role_use.dart';
import 'package:parking_management1/main.dart';

class CarListRoleUserPage extends StatefulWidget {
  final String? loaixe;
  CarListRoleUserPage({Key? key, this.loaixe}) : super(key: key);

  @override
  _CarListRoleUserPageState createState() => _CarListRoleUserPageState();
}

class _CarListRoleUserPageState extends State<CarListRoleUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {
          //     //Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new PageTwo()),)
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => DangkixePage()));
          //   },
          // )
        ],
        backgroundColor: Colors.transparent,
        title: Text("${appUser?.fullName}"),
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

  BlocProvider<VahicleListBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<VahicleListBloc>(),
        child: SingleChildScrollView(
            child: BodyCarListRoleUser(
          loaixe: widget.loaixe,
        )));
  }
}
