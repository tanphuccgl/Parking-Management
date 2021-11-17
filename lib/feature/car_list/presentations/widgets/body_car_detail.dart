import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/alert_dialog1.dart';
import 'package:parking_management1/core/config/components/alert_dialog2.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/car_list/data/data_source/remove_xe.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_details.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_page.dart';
import 'package:parking_management1/feature/home/presentations/pages/home_page.dart';
import 'package:parking_management1/feature/home/presentations/widgets/park_detail.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_page.dart';
import 'package:parking_management1/feature/time/time_all/presentation/pages/time_all_page.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_bloc.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_event.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_state.dart';
import 'package:simple_moment/simple_moment.dart';

class BodyCarDetail extends StatefulWidget {
  final String? biensoxe;
  final int? id;
  BodyCarDetail({Key? key, this.biensoxe, this.id}) : super(key: key);

  @override
  _BodyCarDetailState createState() => _BodyCarDetailState();
}

class _BodyCarDetailState extends State<BodyCarDetail> {
  @override
  Widget build(BuildContext context) {
    var secondsToAdd = new Duration(seconds: 10);
    var dateForComparison = new DateTime.now().add(secondsToAdd);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<VahicleBloc, VahicleState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<VahicleBloc>(context)
              .add((GetVahicleE(id: widget.biensoxe)));
          print("aaaaa    ${widget.id}");
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width / 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.width / 7,
                                  width: size.width / 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text(
                                              'QR CODE of license plate: ' +
                                                  "${state.data!.licensePlate}",
                                              textAlign: TextAlign.center,
                                            ),
                                            content: Container(
                                              height: 200,
                                              child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                      height: 200,
                                                      width: 230,
                                                      child: state.data!.qr !=
                                                              null
                                                          ? Image.memory(Uri.parse(
                                                                  "${state.data!.qr}")
                                                              .data!
                                                              .contentAsBytes())
                                                          : Center(
                                                              child: Text(
                                                                "Please check in to show QR CODE",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ))
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                textColor: Theme.of(context)
                                                    .primaryColor,
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ));
                                },
                                child: Container(
                                  height: size.width / 6.545454545454545,
                                  width: size.width / 6.545454545454545,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Icon(Icons.qr_code),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width / 14.4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${state.data!.nameEmployee}\n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            size.width / 16.36363636363636,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "License plate: ${state.data!.licensePlate}",
                                      style: TextStyle(
                                        fontSize:
                                            size.width / 25.71428571428571,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TimeAllPage(
                                                id: state.data!.licensePlate)));
                                  },
                                  child: Text(
                                    "History",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                          state.data!.typeVehicle == "Xe máy"
                              ? CarouselSlider(
                                  options: CarouselOptions(height: 200.0),
                                  items: [
                                    Image.asset("assets/images/1.jpg"),
                                    Image.asset("assets/images/2.jpg"),
                                    Image.asset("assets/images/3.jpg"),
                                    Image.asset("assets/images/4.jpg"),
                                    Image.asset("assets/images/5.jpg"),
                                  ].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                                color: Colors.amber),
                                            child: i);
                                      },
                                    );
                                  }).toList(),
                                )
                              : CarouselSlider(
                                  options: CarouselOptions(height: 200.0),
                                  items: [
                                    Image.asset("assets/images/6.jpg"),
                                    Image.asset("assets/images/7.jpg"),
                                    Image.asset("assets/images/8.jpg"),
                                    Image.asset("assets/images/9.jpg"),
                                  ].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                                color: Colors.amber),
                                            child: i);
                                      },
                                    );
                                  }).toList(),
                                )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.width / 1.384615384615385,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          size.width / 7.2,
                        ),
                        topRight: Radius.circular(
                          size.width / 7.2,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width / 15,
                      vertical: size.width / 11.25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: size.width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.width / 14.4,
                        ),
                        timeInOut(state.data!.dateIn, state.data!.dateOut),
                        SizedBox(
                          height: size.width / 24,
                        ),
                        Divider(),
                        SizedBox(
                          height: size.width / 24,
                        ),
                        Row(
                          children: [
                            Container(
                              width: size.width / 7.2,
                              height: size.width / 7.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(
                                  size.width / 30,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.restore_from_trash_rounded),
                                onPressed: () {
                                  AlertDialog2.yesAbortDialog(
                                      context: context,
                                      title: "DELETE",
                                      body:
                                          "Do you want to cancel the vehicle registration with license plate number ${widget.biensoxe} ?",
                                      onPressed: () {
                                        removeVahicle(
                                            id: widget.id,
                                            function: () {
                                              showOk();
                                            },
                                            function2: () {
                                              showCancel();
                                            });
                                        //   Navigator.pushNamedAndRemoveUntil(context, PageRoutes.onBoardingPage,(Route<dynamic> route) => false);
                                      });
                                },
                              ),
                            ),
                            SizedBox(
                              width: size.width / 18,
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    size.width /
                                    252,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.circular(size.width / 15),
                                ),
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.width / 16.36363636363636,
                                  ),
                                  onPressed: () {},
                                  child: (state.data!.dateIn != null &&
                                          state.data!.dateOut != null)
                                      ? Text(
                                          "absence status".toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      : (state.data!.dateIn != null &&
                                              state.data!.dateOut == null)
                                          ? Text(
                                              " busy status".toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              "free status".toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is Error) {
          return Text("tam thoi khong hoat dong");
        }
        return Container();
      },
    );
  }

  Widget timeInOut(String? a, String? b) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("            Time in:   ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.bold)),
              a != null
                  ? Text("${a}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.normal))
                  : Text("",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Container(
          width: size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("          Time out:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.bold)),
              b != null
                  ? Text("${b}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.normal))
                  : Text("",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ],
    );
  }

  void showOk() {
    var alert = new AlertDialog1(
      title: "SUCCESS",
      description: "Successfully canceled vehicle registration",
      onPressed: () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      },
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alert;
        });
  }

  void showCancel() {
    var alert = new AlertDialog1(
      title: "ERROR",
      description: "Failed vehicle registration",
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
