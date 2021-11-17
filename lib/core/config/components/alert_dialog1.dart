import 'package:flutter/material.dart';

class AlertDialog1 extends StatelessWidget {
  static const String routeName = '/AlertDialog1';

  final String? title;
  final String? description;
  final Function()? onPressed;

  const AlertDialog1({Key? key, this.title, this.description, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      title!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: size.height / 128,
                    ),
                    Center(
                      child: Text(
                        description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 32,
                    ),
                    RaisedButton(
                      onPressed: onPressed,
                      color: Colors.white,
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
