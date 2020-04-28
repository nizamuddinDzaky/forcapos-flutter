import 'dart:ui';

class MyScreen{
  Size screenSize;

  MyScreen(this.screenSize);

  double wp(percentage) {
    return percentage / 100 * screenSize.width;
  }

  double hp(percentage) {
    return percentage / 100 * screenSize.height;
  }
}