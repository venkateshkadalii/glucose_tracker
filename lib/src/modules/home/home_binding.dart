import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}