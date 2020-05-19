import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

class CustomExpandableButton extends ExpandableButton {
  final Function shareController;
  final Widget child;

  CustomExpandableButton.custom({this.shareController, this.child})
      : super(child: child);

  @override
  Widget build(BuildContext context) {
    shareController(ExpandableController.of(context));
    return super.build(context);
  }
}
