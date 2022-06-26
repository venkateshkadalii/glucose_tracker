import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}