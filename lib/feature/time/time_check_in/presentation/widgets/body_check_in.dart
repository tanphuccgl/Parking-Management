import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';
import 'package:parking_management1/feature/time/time_check_in/data/models/time_check_in_res.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_bloc.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_event.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_state.dart';
import 'package:simple_moment/simple_moment.dart';

class BodyCheckInHistory extends StatefulWidget {
  BodyCheckInHistory({Key? key}) : super(key: key);

  @override
  _BodyCheckInHistoryState createState() => _BodyCheckInHistoryState();
}

class _BodyCheckInHistoryState extends State<BodyCheckInHistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<TimeCheckInBloc, TimeCheckInState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<TimeCheckInBloc>(context).add((TimeCheckInEventE()));
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return Container(
              height: size.height - 100,
              width: size.width,
              color: Colors.white,
              child: Expanded(
                child: Container(
                  child: ClipRRect(
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
                    itemCount: state.swagger!.data!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.black87,
                    ),
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
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: function,
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
            //   color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,

            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 35.0,
                    //   backgroundImage: AssetImage("assets/images/hi.jpg"),
                    // ),
                    // SizedBox(width: 10.0),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${data.typeVehicle}"),
                              Text(" - "),
                              Text(
                                "${data.licensePlate} ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // data.dateIn != null
                              //     ? Text(
                              //         "   ${Moment?.parse("${data.dateIn}").format(" HH:mm dd-MM-yyyy")}",
                              //         style: TextStyle(
                              //           color: Colors.grey,
                              //           fontSize: 15.0,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       )
                              //     : Text(""),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Date in:  ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: data.dateIn != null
                                    ? Text(
                                        "${data.dateIn}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // data.qr != null
                    //     ? Container(
                    //         height: 50,
                    //         width: 48,
                    //         child: Image.memory(
                    //             Uri.parse("${data.qr}").data!.contentAsBytes()))
                    //     : Container(),
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
