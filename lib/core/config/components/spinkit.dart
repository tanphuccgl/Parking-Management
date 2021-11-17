import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitLoading extends StatelessWidget {
  const SpinkitLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
          child: SpinKitCircle(
        color: Colors.amberAccent,
      )),
    );
  }
}
