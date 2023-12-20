import 'package:flutter/material.dart';

class R {
  static double rh(double height, BuildContext context) {
    return MediaQuery.of(context).size.height * (height / 812);
  }

  static double rw(double width, BuildContext context) {
    return MediaQuery.of(context).size.width * (width / 375);
  }
}
