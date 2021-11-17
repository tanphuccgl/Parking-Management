import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/manager/list_vahicle_in_park_bloc.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/widgets/body_list_vahicle_in_park_role_user.dart';

class ListVahicleInParkRoleUserPage extends StatefulWidget {
  final String? loaixe;
  final String? title;
  static const String routeName = "/ListVahicleInParkRoleUserPage";
  ListVahicleInParkRoleUserPage({Key? key, this.loaixe, this.title})
      : super(key: key);

  @override
  _ListVahicleInParkRoleUserPageState createState() =>
      _ListVahicleInParkRoleUserPageState();
}

class _ListVahicleInParkRoleUserPageState
    extends State<ListVahicleInParkRoleUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        actions: [
          //  Icon(Icons.search),
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

  BlocProvider<ListVahicleInParkBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<ListVahicleInParkBloc>(),
        child: SingleChildScrollView(
            child: BodyListVahicleInParkRoleUser(
          loaixe: widget.loaixe,
        )));
  }
}
