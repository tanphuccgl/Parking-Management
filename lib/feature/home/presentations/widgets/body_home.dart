import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/core/config/constants.dart';
import 'package:parking_management1/core/config/injection_container.dart';
import 'package:parking_management1/feature/home/data/models/capacity_res.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_bloc.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_event.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_state.dart';
import 'package:parking_management1/feature/home/presentations/widgets/park_detail.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../main.dart';

class BodyHome extends StatefulWidget {
  BodyHome({Key? key}) : super(key: key);

  @override
  _BodyHomeState createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  String loaixe = "Xe máy";
  String loaixe1 = "Xe ô tô";
  String title = "Car Park";
  String car = "List Car";
  String car1 = "List car in park";
  String moto = "List Motorcycle";
  String moto1 = "List motorcycle in park";

  String title1 = "Motorcycle Park";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height - 55,
      width: size.width,
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width / 18,
            left: size.width / 18,
            right: size.width / 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: size.width / 10),
              child: titleHome(),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(top: size.width / 10),
                child: searchBar(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.width / 20),
              child: Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Locations",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: size.width / 20),
                child: Column(
                  children: <Widget>[
                    BlocProvider(
                      create: (_) => sl<CapacityBloc>(),
                      child: BlocBuilder<CapacityBloc, CapacityState>(
                        builder: (context, state) {
                          if (state is Empty) {
                            BlocProvider.of<CapacityBloc>(context)
                                .add((CapacityEventE(loaixe: loaixe1)));
                          } else if (state is Loading) {
                            return SpinkitLoading();
                          } else if (state is Loaded) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ParkDetail(
                                              loaixe: loaixe1,
                                              title: title,
                                              content: car,
                                              content1: car1,
                                            )));
                              },
                              child: Container(
                                width: size.width,
                                height: size.height / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width / 24))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "assets/images/11.jpg",
                                          fit: BoxFit.cover,
                                          height: size.width / 4,
                                          width: size.width / 4,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: size.width / 30),
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width / 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: size.width / 30),
                                          child: LinearPercentIndicator(
                                            width: size.width / 2.3,
                                            lineHeight: 15.0,
                                            percent: state.data!.nowVehicle! /
                                                (state.data!.capacity!),
                                            backgroundColor: Colors.black26,
                                            progressColor: Colors.amberAccent,
                                          ),
                                        ),
                                        Container(
                                          width: size.width / 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${state.data!.nowVehicle}/${state.data!.capacity}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width / 30,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                "${(state.data!.nowVehicle! / (state.data!.capacity!) * 100).toInt()}% Occpuied",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width / 30,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (state is Error) {
                            return Text("tam thoi khong hoat dong");
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    BlocProvider(
                      create: (_) => sl<CapacityBloc>(),
                      child: BlocBuilder<CapacityBloc, CapacityState>(
                        builder: (context, state) {
                          if (state is Empty) {
                            BlocProvider.of<CapacityBloc>(context)
                                .add((CapacityEvent1E(loaixe: loaixe)));
                          } else if (state is Loading) {
                            return SpinkitLoading();
                          } else if (state is Loaded) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ParkDetail(
                                              loaixe: loaixe,
                                              title: title1,
                                              content: moto,
                                              content1: moto1,
                                            )));
                              },
                              child: Container(
                                width: size.width,
                                height: size.height / 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.width / 24))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "assets/images/10.jpg",
                                          fit: BoxFit.cover,
                                          height: size.width / 4,
                                          width: size.width / 4,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: size.width / 30),
                                          child: Text(
                                            title1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: size.width / 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: size.width / 30),
                                          child: LinearPercentIndicator(
                                            width: size.width / 2.3,
                                            lineHeight: 15.0,
                                            percent: state.data!.nowVehicle! /
                                                (state.data!.capacity!),
                                            backgroundColor: Colors.black26,
                                            progressColor: Colors.amberAccent,
                                          ),
                                        ),
                                        Container(
                                          width: size.width / 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "${state.data!.nowVehicle}/${state.data!.capacity}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width / 30,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              Text(
                                                "${(state.data!.nowVehicle! / (state.data!.capacity!) * 100).toInt()}% Occpuied",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: size.width / 30,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (state is Error) {
                            return Text("tam thoi khong hoat dong");
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 13,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size.width / 24)),
          color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            width: size.width / 36,
          ),
          Container(
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: size.width / 36,
          ),
          Container(
            child: Text(
              'Search Parkings',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleHome() {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        appUser?.role == "admin"
            ? Text(
                "Hey Admin,",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width / 17,
                    fontWeight: FontWeight.w400),
              )
            : Text(
                "Hey ${appUser?.fullName},",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width / 17,
                    fontWeight: FontWeight.w400),
              ),
        Text(
          "Welcome to",
          style: TextStyle(
              color: Colors.white,
              fontSize: size.width / 13,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "ParkHunter",
          style: TextStyle(
              color: Colors.white,
              fontSize: size.width / 13,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
