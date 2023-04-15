import 'package:flutter/material.dart';


TextStyle _getTextStyle({
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle getTitleStyle({
  required double fontSize ,
  required Color color,
  required FontWeight fontWeight,
}) {
  return _getTextStyle(
      color: color, fontSize: fontSize, fontWeight: fontWeight);
}

