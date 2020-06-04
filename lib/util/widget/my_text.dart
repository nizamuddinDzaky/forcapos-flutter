import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FontSize { small, medium, large }

double getFontSize(FontSize size) {
  switch (size) {
    case FontSize.small:
      return 14;
    case FontSize.medium:
      return 16;
    case FontSize.large:
      return 18;
    default:
      return 12;
  }
}

class MyText {
  static textBlackSmall(text,
      {isBold = false, maxLine = 3, txtOverflow = TextOverflow.ellipsis}) {
    return Text(
      text ?? "~",
      maxLines: maxLine,
      overflow: txtOverflow,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  static textWhite(text, {FontSize fontSize, isTitle = false, isBold = false}) {
    return Text(
      text ?? "~",
      style: TextStyle(
          fontSize: getFontSize(fontSize),
          color: Colors.white,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontFamily: isTitle ? 'Panton' : null),
    );
  }
}
