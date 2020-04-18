import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Widget customAction(
      {Function onPressed,
      Widget newChild,
      String name = 'Ya',
      Color newColor}) {
    return CupertinoDialogAction(
      onPressed: onPressed ??
          () {
            Get.back();
          },
      child: newChild ??
          Text(
            name ?? 'Ya',
            style: TextStyle(color: newColor),
          ),
    );
  }

  static showAlertDialog(BuildContext context,
      {String title = 'Perhatian',
      String message,
      Widget leftAction,
      Widget rightAction}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: message == null ? message : new Text(message),
        actions: [
          if (leftAction != null) leftAction,
          if (rightAction != null) rightAction,
        ],
      ),
    );
  }
}
