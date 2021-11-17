import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_management1/core/config/components/spinkit.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar_user.dart';
import 'package:parking_management1/feature/user_list/data/models/user_get_vehicle_response_model.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_bloc.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_event.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_state.dart';
import 'package:parking_management1/main.dart';

class BodyQrCode extends StatefulWidget {
  BodyQrCode({Key? key}) : super(key: key);

  @override
  _BodyQrCodeState createState() => _BodyQrCodeState();
}

class _BodyQrCodeState extends State<BodyQrCode> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<UserGetVahicleBloc, UserGetVahicleState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<UserGetVahicleBloc>(context)
              .add((UserGetVahicleE(id: appUser!.iId)));
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return Container(
            height: size.height,
            color: Colors.black87,
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    height: size.height,
                  ),
                  items: state.data!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                "${i.typeVehicle} - ${i.licensePlate}",
                                style: TextStyle(color: Colors.amberAccent),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 430,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(color: Colors.white),
                                child: i.qr != null
                                    ? Container(
                                        height: 300,
                                        width: 300,
                                        child: Image.memory(Uri.parse("${i.qr}")
                                            .data!
                                            .contentAsBytes()),
                                      )
                                    : Center(
                                        child: Text(
                                          "Please check in to show QR CODE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  map<Widget>(state.data ?? [], (index, url) {
                                return Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? Colors.blueAccent
                                        : Colors.grey,
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else if (state is Error) {
          return Text("tam thoi khong hoat dong");
        }
        return Container();
      },
    );
  }

  List<Message> map<Message>(List list, Function handler) {
    List<Message> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
