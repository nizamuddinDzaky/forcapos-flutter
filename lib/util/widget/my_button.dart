import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/style/my_decoration.dart';
import 'package:posku/util/widget/my_text.dart';

class MyButton {
  static buttonAction(String text, VoidCallback onPressed,
      {double addPad = 0, noIcon = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: addPad),
      decoration: MyDecoration.decorationGradient(withBoxShadow: true, withRounded: true),
      child: CupertinoButton(
          child: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: noIcon
                  ? [MyText.textWhite(text, fontSize: FontSize.medium)]
                  : [
                MyText.textWhite(text, fontSize: FontSize.medium),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          color: Colors.transparent,
          onPressed: onPressed,
      ),
    );
  }
}