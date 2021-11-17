import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar_user.dart';
import 'package:parking_management1/feature/qr_code/user/presentation/widgets/body_qr_code.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_bloc.dart';

class QrCodeUserPage extends StatefulWidget {
  static const String routeName = "/QrCodeUserPage";
  QrCodeUserPage({Key? key}) : super(key: key);

  @override
  _QrCodeUserPageState createState() => _QrCodeUserPageState();
}

class _QrCodeUserPageState extends State<QrCodeUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBarUser(
          index: 1,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          title: const Text('QR CODE'),
          centerTitle: true,
        ),
        body: buildBody(context));
  }

  BlocProvider<UserGetVahicleBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserGetVahicleBloc>(),
        child: SingleChildScrollView(child: BodyQrCode()));
  }
}
