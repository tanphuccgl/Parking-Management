import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_bloc.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_event.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_state.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_get_vehicle.dart';

class BodyUserList extends StatefulWidget {
  BodyUserList({Key? key}) : super(key: key);

  @override
  _BodyUserListState createState() => _BodyUserListState();
}

class _BodyUserListState extends State<BodyUserList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, UserState>(
      builder: (context, state) {
        if (state is Empty) {
          getProductLoai5();
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return Container(
              height: size.height - 100,
              width: size.width,
              color: Colors.black,
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return itemList(() {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ListUserGetVehiclePage(
                                              id: state.data![index].iId,
                                              account:
                                                  state.data![index].username,
                                              name: state
                                                  .data![index].fullName)));
                            });
                          }, state.data![index]);
                        },
                        itemCount: state.swagger!.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      )),
                ),
              ));
        } else if (state is Error) {
          return Text("tam thoi khong hoat dong");
        }
        return Container();
      },
    );
  }

  void getProductLoai5() {
    BlocProvider.of<ProductBloc>(context).add((GetUserE()));
  }

  Widget itemList(Function()? function, Data data) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          //   color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage("assets/images/hi.jpg"),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${data.fullName}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                // Text(
                //   "11:09",
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 15.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 5.0),
                // //   chat.unread ?
                // Container(
                //   width: 40.0,
                //   height: 20.0,
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: BorderRadius.circular(30.0),
                //   ),
                //   alignment: Alignment.center,
                //   child: Text(
                //     'NEW',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
                //   : Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
