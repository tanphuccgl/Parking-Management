import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_bloc.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/pages/dangkyaccount_page.dart';
import 'package:parking_management1/feature/user_list/widgets/body_usser_list.dart';

class ListUserPage extends StatefulWidget {
  static const String routeName = "/ListUserPage";
  ListUserPage({Key? key}) : super(key: key);

  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DangKyAccountPage()));
            },
          )
        ],
        backgroundColor: Colors.transparent,
        title: Text("List User"),
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

  BlocProvider<ProductBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<ProductBloc>(),
        child: SingleChildScrollView(child: BodyUserList()));
  }
}
