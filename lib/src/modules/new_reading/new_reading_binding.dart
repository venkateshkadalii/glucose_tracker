import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/new_reading/new_reading_controller.dart';

class NewReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewReadingController());
  }

}