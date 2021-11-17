import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_bloc.dart';
import 'package:parking_management1/feature/car_list/presentations/widgets/body_car_list.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/data_source/dk_account_remote.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyxe_page.dart';
import 'package:provider/provider.dart';

class CarListPage extends StatefulWidget {
  final String? loaixe;
  final String? title;
  static const String routeName = "/CarListPage";
  CarListPage({Key? key, this.loaixe, this.title}) : super(key: key);

  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new PageTwo()),)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DangkixePage()));
            },
          )
        ],
        backgroundColor: Colors.transparent,
        title: Text("${widget.title}"),
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
            child: BodyCarList(
          loaixe: widget.loaixe,
        )));
  }
}
