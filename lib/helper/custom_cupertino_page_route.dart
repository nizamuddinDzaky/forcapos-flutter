import 'package:flutter/cupertino.dart';

class CustomCupertinoPageRoute extends CupertinoPageRoute {
  dynamic resultPop;

  @override
  get currentResult => resultPop;

  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomCupertinoPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );
}