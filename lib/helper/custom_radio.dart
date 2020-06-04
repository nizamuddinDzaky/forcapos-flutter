import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posku/util/resource/my_color.dart';

class RadioModel {
  String title;
  dynamic value;

  RadioModel({this.title, this.value});
}

class CustomRadio extends StatefulWidget {
  final List<RadioModel> dataRadioGroup;
  final ValueChanged<dynamic> callback;
  final dynamic defaultValue;

  CustomRadio({
    @required this.dataRadioGroup,
    this.defaultValue,
    this.callback,
  });

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  dynamic currentValue;

  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      currentValue = widget.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (widget.dataRadioGroup != null)
          ...widget.dataRadioGroup.map((data) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                constraints: BoxConstraints(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: MyColor.mainRed),
                ),
                onPressed: () {
                  setState(() {
                    currentValue = data.value;
                    if (widget.callback != null) {
                      widget.callback(currentValue);
                    }
                  });
                },
                fillColor:
                currentValue == data.value ? MyColor.mainRed : Colors.white,
                child: Text(
                  data.title,
                  style: TextStyle(
                    color: currentValue == data.value
                        ? Colors.white
                        : MyColor.txtField,
                  ),
                ),
              ),
            );
          }).toList(),
      ],
    );
  }
}
