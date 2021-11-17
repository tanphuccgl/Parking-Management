import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar_user.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_bloc.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/widgets/body_check_in.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/widgets/body_history_user.dart';
import 'package:parking_management1/feature/time/time_check_out/presentation/manager/time_check_out_bloc.dart';
import 'package:parking_management1/feature/time/time_check_out/presentation/widgets/body_check_out.dart';
import 'package:parking_management1/feature/user_history/presentation/manager/user_hic_bloc.dart';
import 'package:parking_management1/main.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = "/HistoryPage";
  HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return appUser?.role == "admin"
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              bottomNavigationBar: CustomBottomNavigationBar(
                index: 3,
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black87,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "Check In",
                    ),
                    Tab(
                      text: "Check Out",
                    ),
                  ],
                ),
                title: const Text('History'),
                centerTitle: true,
              ),
              body: TabBarView(
                children: [
                  buildBody(context),
                  buildBody1(context),
                ],
              ),
            ),
          )
        : Scaffold(
            bottomNavigationBar: CustomBottomNavigationBarUser(
              index: 2,
            ),
            appBar: AppBar(
              title: Text("History"),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.black87,
            ),
            body: buildBody3(context),
          );
  }

  BlocProvider<UserHistoryBloc> buildBody3(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserHistoryBloc>(), child: BodyHistoryUser());
  }

  BlocProvider<TimeCheckInBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<TimeCheckInBloc>(), child: BodyCheckInHistory());
  }

  BlocProvider<TimeCheckOutBloc> buildBody1(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<TimeCheckOutBloc>(), child: BodyCheckOutHistory());
  }
}
