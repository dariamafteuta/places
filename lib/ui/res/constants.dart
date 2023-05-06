import 'package:flutter/material.dart';
import 'package:flutter_job/main.dart';

final errorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: themeProvider.appTheme.redColor,
  ),
);

final enableBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: themeProvider.appTheme.greenColor,
  ),
  borderRadius: BorderRadius.circular(10),
);

final focusBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: themeProvider.appTheme.greenColor,
  ),
  borderRadius: BorderRadius.circular(10),
);

final divider = Divider(
  color: themeProvider.appTheme.inactiveColor,
  thickness: 0.8,
);

const sizedBox2H = SizedBox(height: 2);

const sizedBox8H = SizedBox(height: 8);

const sizedBox10H = SizedBox(height: 10);

const sizedBox12H = SizedBox(height: 12);

const sizedBox24H = SizedBox(height: 24);

const sizedBox32H = SizedBox(height: 32);

const sizedBox42H = SizedBox(height: 42);

const sizedBox60H = SizedBox(height: 60);


const sizedBox24W = SizedBox(width: 24);

const sizedBox10W = SizedBox(width: 10);

const sizedBox50W = SizedBox(width: 50);

