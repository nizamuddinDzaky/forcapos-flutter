import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';

class MyDecoration {
  static decorationGradient(
      {withBoxShadow = false, withRounded = false, top2bottom = false}) {
    return BoxDecoration(
        borderRadius:
            withRounded ? BorderRadius.circular(MyDimen.circularMedium) : null,
        gradient: LinearGradient(
          colors: [
            MyColor.mainBlue,
            MyColor.getBlue(),
//            MyColor.getAqua(),
          ],
          begin: top2bottom
              ? FractionalOffset.topCenter
              : FractionalOffset.centerLeft,
          end: top2bottom
              ? FractionalOffset.bottomCenter
              : FractionalOffset.centerRight,
        ),
        boxShadow: withBoxShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 6,
                    offset: Offset(1, 3)),
              ]
            : null);
  }

  static decorationInputTextField({prefixIconData, min = 0}) {
    return InputDecoration(
        contentPadding: prefixIconData != null
            ? EdgeInsets.symmetric(vertical: 0, horizontal: 10)
            : EdgeInsets.symmetric(vertical: 15.5 - min, horizontal: 20),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyDimen.circularInput()),
            borderSide: BorderSide(color: MyColor.getAqua())
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MyDimen.circularInput()),
            borderSide: BorderSide(color: MyColor.getBgFieldBorder())
        ),
        filled: true,
        prefixIcon: prefixIconData != null
            ? Icon(
          prefixIconData,
          size: 15,
        )
            : null,
        hintStyle: TextStyle(color: Colors.grey[800]),
        fillColor: MyColor.getBgField());
  }

  static styleFieldLogin() {
    return TextStyle(fontSize: 14);
  }
}
