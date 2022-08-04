import 'package:flutter/material.dart';

class Utils {
  static Widget customText({
    text = "",
    color = Colors.black87,
    size = 16.0,
    fontWeight = FontWeight.normal,
    line = 3,
    textAlign = TextAlign.left,
    decoration = TextDecoration.none,
    fontStyle=FontStyle.normal
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: color,
          height: 1.4,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration),
      textAlign: textAlign,
      maxLines: line,
      overflow: TextOverflow.ellipsis,
    );
  }
}