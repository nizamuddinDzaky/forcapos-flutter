import 'package:get/get.dart';
import 'package:posku/app/my_router.dart';

class MiddleWare {
  static observer(Routing routing) {
    ///Trigger any event when a route is pushed or popped by Get.
    /// You can listen in addition to the routes, the snackbars, dialogs and bottomsheets on each screen.
    ///If you need to enter any of these 3 events directly here,
    ///you must specify that the event is != Than you are trying to do.
    if (routing.current == loginScreen && routing.isSnackbar == false) {
      //Get.snackbar("Hi", "You are on second route");
    } else if (routing.current == root) {
      //print('last route called');
    }
  }
}