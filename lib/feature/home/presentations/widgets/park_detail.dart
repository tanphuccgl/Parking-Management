import 'package:flutter/material.dart';
import 'package:parking_management1/core/config/components/page_routers.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_page.dart';
import 'package:parking_management1/feature/car_list/presentations/pages/car_list_role_user_page.dart';
import 'package:parking_management1/feature/home/presentations/widgets/custom_bottom_navigation_bar.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/usecase/list_vahicle_in_park.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_page.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/pages/list_vahicle_in_park_role_user_page.dart';
import 'package:parking_management1/feature/user_list/pages/list_user_page.dart';
import 'package:parking_management1/main.dart';

class Item {
  String? title;
  String? subtitle;
  String? event;
  String? img;
  Function()? function;

  Item({this.title, this.subtitle, this.event, this.img, this.function});
}

class ParkDetail extends StatefulWidget {
  final String? loaixe;
  final String? title;
  final String? content;

  final String? content1;
  static const String routeName = "/ParkDetail";
  ParkDetail({Key? key, this.loaixe, this.title, this.content, this.content1})
      : super(key: key);

  @override
  _ParkDetailState createState() => _ParkDetailState();
}

class _ParkDetailState extends State<ParkDetail> {
  @override
  Widget build(BuildContext context) {
    Item item1 = new Item(
        title: "${widget.content}",

        //   img: "assets/icons/showroom.png",
        function: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CarListPage(
                        loaixe: widget.loaixe,
                        title: widget.content,
                      )));
        });

    Item item2 = new Item(
      title: "${widget.content1}",

      //  img: "assets/icons/add.png",
      function: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListVahicleInParkPage(
                      title: widget.content1,
                      loaixe: widget.loaixe,
                    )));
      },
    );
    Item item3 = new Item(
      title: "Person",

      //  img: "assets/icons/add.png",
      function: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListUserPage()));
      },
    );
    Item item4 = new Item(
        title: "${widget.content}",

        //   img: "assets/icons/showroom.png",
        function: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CarListRoleUserPage(
                        loaixe: widget.loaixe,
                      )));
        });
    Item item5 = new Item(
        title: "${widget.content1}",

        //   img: "assets/icons/showroom.png",
        function: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListVahicleInParkRoleUserPage(
                        loaixe: widget.loaixe,
                        title: widget.content1,
                      )));
        });

    List<Item> myList = [
      item1,
      item2,
      item3,
    ];
    List<Item> myList1 = [
      item4,
      item5,
    ];
    Future<bool> onWillPop() async {
      Navigator.pop(context);
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      return Future.value(true);
    }

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, PageRoutes.homePage);
            },
          ),
        ),
        body: Container(
          color: Colors.black87,
          child: Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.title}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 64,
                ),
                Expanded(
                    child: appUser!.role == "admin"
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: myList[index].function,
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.amberAccent),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Image.asset(
                                        //   myList[index].img!,
                                        //   width: size.width / 8.571428571428571,
                                        // ),
                                        SizedBox(
                                          height: size.height / 128,
                                        ),
                                        Text(myList[index].title!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: size.height / 80,
                                        ),

                                        SizedBox(
                                          height:
                                              size.height / 45.71428571428571,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            itemCount: myList.length,
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: myList1[index].function,
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.amberAccent,
                                            width: 5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Image.asset(
                                        //   myList[index].img!,
                                        //   width: size.width / 8.571428571428571,
                                        // ),
                                        SizedBox(
                                          height: size.height / 128,
                                        ),
                                        Text(myList1[index].title!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: size.height / 80,
                                        ),

                                        SizedBox(
                                          height:
                                              size.height / 45.71428571428571,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            itemCount: myList1.length,
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
