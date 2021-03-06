import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IOSSearchBar extends AnimatedWidget {
  IOSSearchBar({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  /// The text editing controller to control the search field
  final TextEditingController controller;

  /// The focus node needed to manually unfocus on clear/cancel
  final FocusNode focusNode;

  /// The function to call when the "Cancel" button is pressed
  final Function onCancel;

  /// The function to call when the "Clear" button is pressed
  final Function onClear;

  /// The function to call when the text is updated
  final Function(String) onUpdate;

  /// The function to call when the text field is submitted
  final Function(String) onSubmit;

  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: new BoxDecoration(
                color: CupertinoColors.white,
                border:
                    new Border.all(width: 0.0, color: CupertinoColors.white),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 1.0),
                        child: new Icon(
                          CupertinoIcons.search,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                      new Text(
                        'Cari Transaksi',
                        style: new TextStyle(
                          inherit: false,
                          color: CupertinoColors.inactiveGray.withOpacity(
                            _opacityTween.evaluate(animation),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: new EditableText(
                            controller: controller,
                            focusNode: focusNode,
                            onChanged: onUpdate,
                            onSubmitted: onSubmit,
                            style: new TextStyle(
                              color: CupertinoColors.black,
                              inherit: false,
                            ),
                            cursorColor: CupertinoColors.black,
                            backgroundCursorColor: CupertinoColors.black,
                          ),
                        ),
                      ),
                      new CupertinoButton(
                        minSize: 10.0,
                        padding: const EdgeInsets.all(1.0),
                        borderRadius: new BorderRadius.circular(30.0),
                        color: CupertinoColors.inactiveGray.withOpacity(
                          1.0 - _opacityTween.evaluate(animation),
                        ),
                        child: new Icon(
                          Icons.close,
                          size: 16.0,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () {
                          if (animation.isDismissed)
                            return;
                          else
                            onClear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SizedBox(
            width: _paddingTween.evaluate(animation),
            child: new CupertinoButton(
              padding: const EdgeInsets.only(left: 8.0),
              onPressed: onCancel,
              child: new Text(
                'Batal',
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
