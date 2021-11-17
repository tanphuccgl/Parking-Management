import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_bloc.dart';
import 'package:parking_management1/feature/time/time_all/presentation/widgets/body_time_all.dart';

class TimeAllPage extends StatefulWidget {
  final String? id;
  static const String routeName = "/TimeAllPage";
  TimeAllPage({Key? key, this.id}) : super(key: key);

  @override
  _TimeAllPageState createState() => _TimeAllPageState();
}

class _TimeAllPageState extends State<TimeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        // actions: [
        //   Icon(Icons.search),
        //   SizedBox(
        //     width: 10,
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       //Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new PageTwo()),)
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => DangkixePage()));
        //     },
        //   )
        // ],
        backgroundColor: Colors.transparent,
        title: Text("History for ${widget.id}"),
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

  BlocProvider<TimeAllBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<TimeAllBloc>(),
        child: SingleChildScrollView(
            child: BodyTimeAll(
          id: widget.id,
        )));
  }
}
