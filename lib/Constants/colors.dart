import 'package:flutter/material.dart';

const Color mainColor1 = Color(0xffF8B300);
const Color mainColor2 = Color(0xff434343);


extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  Future push(Widget widget) async {
    return Navigator.push(
        this, MaterialPageRoute(builder: (context) => widget));
  }

  void pop() async {
    return Navigator.pop(this);
  }
}