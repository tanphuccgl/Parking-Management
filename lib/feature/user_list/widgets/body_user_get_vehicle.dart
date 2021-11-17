import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_bloc.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_event.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_state.dart';

class BodyUserGetVehicle extends StatefulWidget {
  final int? id;

  BodyUserGetVehicle({Key? key, this.id}) : super(key: key);

  @override
  _BodyUserGetVehicleState createState() => _BodyUserGetVehicleState();
}

class _BodyUserGetVehicleState extends State<BodyUserGetVehicle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<UserGetVahicleBloc, UserGetVahicleState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<UserGetVahicleBloc>(context)
              .add((UserGetVahicleE(id: widget.id)));
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
                                            id: state.data![index].iId,
                                            biensoxe:
                                                state.data![index].licensePlate,
                                          )));
                            });
                          }, state.data![index]);
                        },
                        itemCount: state.swagger!.message!.length,
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

  Widget itemList(Function()? function, Message data) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/images/hi.jpg"),
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${data.typeVehicle}",
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
                            "${data.licensePlate}",
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
                data.qr != null
                    ? Container(
                        height: 50,
                        width: 48,
                        child: Image.memory(
                            Uri.parse("${data.qr}").data!.contentAsBytes()))
                    : Container(),
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
