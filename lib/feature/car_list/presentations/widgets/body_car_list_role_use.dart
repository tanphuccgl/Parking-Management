import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_bloc.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_event.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_state.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';

import 'package:parking_management1/main.dart';

class BodyCarListRoleUser extends StatefulWidget {
  final String? loaixe;
  BodyCarListRoleUser({Key? key, this.loaixe}) : super(key: key);

  @override
  _BodyCarListRoleUserState createState() => _BodyCarListRoleUserState();
}

class _BodyCarListRoleUserState extends State<BodyCarListRoleUser> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<VahicleListBloc, VahicleListState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<VahicleListBloc>(context).add((VahicleListEventE(
              name: "keySearchName=${appUser!.fullName}&",
              loaixe: widget.loaixe)));
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
                                      builder: (context) => CarDetail(
                                            biensoxe:
                                                state.data![index].licensePlate,
                                            id: state.data![index].iId,
                                          )));
                            });
                          }, state.data![index]);
                        },
                        itemCount: state.data!.length,
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/images/hi.jpg"),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${data.licensePlate}",
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
                            "${data.nameEmployee}",
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
                    data.qr != null
                        ? Container(
                            height: 50,
                            width: 48,
                            child: Image.memory(
                                Uri.parse("${data.qr}").data!.contentAsBytes()))
                        : Container(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
