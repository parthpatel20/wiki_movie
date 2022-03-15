import 'package:flutter/material.dart';

Widget textTitleRed({String title = "", int fontSize = 15}) {
  return Text(title.toUpperCase(),
      style: TextStyle(
        fontSize: fontSize.toDouble(),
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
      ));
}
