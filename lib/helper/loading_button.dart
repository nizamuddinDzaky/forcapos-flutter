import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';

class LoadingButton extends StatefulWidget {
  LoadingButton({
    @required this.onPressed,
    @required this.title,
    this.noMargin = false,
  });

  final Function onPressed;
  final String title;
  final bool noMargin;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  var isLoading = false;

  actionOnPressed() async {
    setState(() {
      isLoading = true;
    });
//    await Future.delayed(Duration(seconds: 3));
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.noMargin ? null : MyDimen.marginLayout(),
      width: double.maxFinite,
      child: FlatButton(
        color: MyColor.mainGreen,
        disabledColor: MyColor.mainGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? CupertinoActivityIndicator()
                : Text(
                    widget.title,
                    style: TextStyle(color: Colors.white),
                  ),
          ],
        ),
        onPressed: isLoading ? null : actionOnPressed,
      ),
    );
  }
}
