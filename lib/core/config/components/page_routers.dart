import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_page.dart';
import 'package:parking_management1/feature/check_in/presentations/pages/check_in_page.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/home/presentations/widgets/park_detail.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_page.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_role_user_page.dart';
import 'package:parking_management1/feature/login/presentations/pages/login_page.dart';
import 'package:parking_management1/feature/qr_code/presentations/pages/qr_scan_page.dart';
import 'package:parking_management1/feature/qr_code/user/presentation/pages/qr_code_user.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyaccount_page.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyxe_page.dart';
import 'package:parking_management1/feature/time/time_all/presentation/pages/time_all_page.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/pages/history_page.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_get_vehicle.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_page.dart';

class PageRoutes {
  static const String loginPage = LoginPage.routeName;
  static const String carList = CarListPage.routeName;

  static const String homePage = HomePage.routeName;

  static const String qrScanPage = QrScanPage.routeName;
  static const String carDetails = CarDetail.routeName;
  static const String parkDetail = ParkDetail.routeName;
  static const String dangkyXe = DangkixePage.routeName;
  static const String dangkyAccount = DangKyAccountPage.routeName;

  static const String listUserPage = ListUserPage.routeName;
  static const String listUserGetVahicle = ListUserGetVehiclePage.routeName;
  static const String checkInPage = CheckInPage.routeName;
  static const String timeAllPage = TimeAllPage.routeName;
  static const String historyPage = HistoryPage.routeName;
  static const String listVahicleInParkPage = ListVahicleInParkPage.routeName;
  static const String qrCodeUserPage = QrCodeUserPage.routeName;
  static const String listVahicleInParkRoleUserPage =
      ListVahicleInParkRoleUserPage.routeName;
}
