import 'package:get/get.dart';
import 'package:glucose_tracker/src/modules/registration/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}