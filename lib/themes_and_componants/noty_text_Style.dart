
import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle notyTextStyle=const TextStyle(
    fontSize: 40,
    color: nColor,
    letterSpacing: 16,
    fontWeight: FontWeight.bold,
    shadows: [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black38,
        spreadRadius: 1,
        blurRadius:   5,
      ),
      BoxShadow(
        offset: Offset(-2, -2),
        color: Colors.white,
        spreadRadius: 1,
        blurRadius:  5,
      ),
    ]

);

const Color nColor=Colors.black;