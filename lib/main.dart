
import 'package:flutter/material.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_page.dart';
import 'package:parking_management1/feature/check_in/presentations/pages/check_in_page.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/home/presentations/widgets/park_detail.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_page.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_role_user_page.dart';
import 'package:parking_management1/feature/login/data/models/login_response_model.dart';
import 'package:parking_management1/feature/login/presentations/pages/login_page.dart';
import 'package:parking_management1/feature/qr_code/presentations/pages/qr_scan_page.dart';
import 'package:parking_management1/feature/qr_code/user/presentation/pages/qr_code_user.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyaccount_page.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyxe_page.dart';
import 'package:parking_management1/feature/time/time_all/presentation/pages/time_all_page.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/pages/history_page.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_get_vehicle.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

SharedPreferences? prefs;
LoginData? appUser;

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // //  initialRoute: widget.initScreen ==0 || widget.initScreen==null ?? ,
      routes: {
        PageRoutes.homePage: (context) => HomePage(),
        PageRoutes.carList: (context) => CarListPage(),
        PageRoutes.loginPage: (context) => LoginPage(),
        PageRoutes.qrScanPage: (context) => QrScanPage(),
        PageRoutes.carDetails: (context) => CarDetail(),
        PageRoutes.parkDetail: (context) => ParkDetail(),
        PageRoutes.dangkyXe: (context) => DangkixePage(),
        PageRoutes.dangkyAccount: (context) => DangKyAccountPage(),
        PageRoutes.listUserPage: (context) => ListUserPage(),
        PageRoutes.listUserGetVahicle: (context) => ListUserGetVehiclePage(),
        PageRoutes.checkInPage: (context) => CheckInPage(),
        PageRoutes.timeAllPage: (context) => TimeAllPage(),
        PageRoutes.historyPage: (context) => HistoryPage(),
        PageRoutes.listVahicleInParkPage: (context) => ListVahicleInParkPage(),
        PageRoutes.qrCodeUserPage: (context) => QrCodeUserPage(),
        PageRoutes.listVahicleInParkRoleUserPage: (context) =>
            ListVahicleInParkRoleUserPage(),
      },
    );
  }
}
