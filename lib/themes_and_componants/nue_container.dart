
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget NeuContainer({
  required double width,
  required double height,
  required Widget child,
  bool isLight=false

}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color:Colors.grey[200],
      boxShadow:  [
        BoxShadow(
          offset: Offset(6, 6),
          color: Colors.black38,
          spreadRadius: 1,
          blurRadius: isLight? 16: 8,
        ),
        BoxShadow(
          offset: Offset(-6, -6),
          color: Colors.white,
          spreadRadius: 1,
          blurRadius: isLight? 16: 8,
        ),
      ],
    ),
    child: child,
  );
}
