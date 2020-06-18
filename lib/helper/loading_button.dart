import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';
import 'package:posku/util/resource/my_dimen.dart';

class LoadingButton extends StatefulWidget {
  LoadingButton({
    @required this.onPressed,
    @required this.title,
    this.noMargin = false,
    this.isActionNavigation = false,
    this.noPadding = false,
    this.shrinkWrap = false,
    this.isSpinner = false,
    this.color,
  });

  final Function onPressed;
  final String title;
  final bool noMargin;
  final bool isActionNavigation;
  final bool noPadding;
  final bool shrinkWrap;
  final bool isSpinner;
  final Color color;

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
//      width: widget.isActionNavigation ? null : double.maxFinite,
      child: widget.isActionNavigation
          ? CupertinoButton(
              minSize: widget.noPadding ? 0 : null,
              padding: widget.noPadding
                  ? EdgeInsets.symmetric(
                      vertical: 8,
                    )
                  : null,
              onPressed: isLoading ? null : actionOnPressed,
              child: isLoading
                  ? CupertinoActivityIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.isSpinner
                            ? Flexible(child: Text(widget.title))
                            : Text(widget.title),
                        if (widget.isSpinner)
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                      ],
                    ),
            )
          : FlatButton(
              materialTapTargetSize:
                  widget.shrinkWrap ? MaterialTapTargetSize.shrinkWrap : null,
              color: widget.color ?? MyColor.mainGreen,
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
