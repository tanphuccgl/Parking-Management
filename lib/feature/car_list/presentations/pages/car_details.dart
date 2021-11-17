import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/car_list/presentations/widgets/body_car_detail.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_bloc.dart';

class CarDetail extends StatefulWidget {
  final String? biensoxe;
  final int? id;

  static const String routeName = "/CarDetail";
  CarDetail({Key? key, this.biensoxe, this.id}) : super(key: key);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail>
    with SingleTickerProviderStateMixin {
  // Animation setups

  // Keep track of selected car index;
  int selectedIndex = 0;
  // setup animations

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(
        0XFFF4F4FF,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<VahicleBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<VahicleBloc>(),
        child: SingleChildScrollView(
            child: BodyCarDetail(
          biensoxe: widget.biensoxe,
          id: widget.id,
        )));
  }
}
