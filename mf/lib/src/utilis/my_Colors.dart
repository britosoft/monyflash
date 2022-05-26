import 'package:flutter/material.dart';

class MyColors {
  static Color primaryColor = Color(0xff000000);
  static Color secundaryColor = Color(0xFFefb810);
  static Color whiteColor = Color(0xFFffffff);
  static Color secundaryOpacityColor = Color.fromRGBO(212, 175, 55, 09.0);
}

class Background extends StatelessWidget {
  const Background({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
