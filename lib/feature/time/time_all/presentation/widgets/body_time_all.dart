import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/time/time_all/data/models/time_all_res.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_bloc.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_event.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_state.dart';
import 'package:simple_moment/simple_moment.dart';

class BodyTimeAll extends StatefulWidget {
  final String? id;
  BodyTimeAll({Key? key, this.id}) : super(key: key);

  @override
  _BodyTimeAllState createState() => _BodyTimeAllState();
}

class _BodyTimeAllState extends State<BodyTimeAll> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<TimeAllBloc, TimeAllState>(
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => CarDetail(
                              //             id: state
                              //                 .data![index].licensePlate)));
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
    BlocProvider.of<TimeAllBloc>(context)
        .add((TimeAllEventE(loaixe: widget.id)));
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                              data.dateIn != null
                                  ? Text(
                                      "   ${data.dateIn}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(""),
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
                                "Date out:  ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: data.dateOut != null
                                    ? Text(
                                        "${data.dateOut}",
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
