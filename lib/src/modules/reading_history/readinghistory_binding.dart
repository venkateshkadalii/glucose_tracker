import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:glucose_tracker/src/modules/reading_history/readinghistory_controller.dart';

class ReadingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingHistoryController());
  }

}