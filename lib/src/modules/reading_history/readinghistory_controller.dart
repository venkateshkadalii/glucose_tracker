import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/db_helper/db_helper.dart';
import 'package:glucose_tracker/src/models/reading.dart';
import 'package:glucose_tracker/src/services/remote_services.dart';
import 'package:hive/hive.dart';

class ReadingHistoryController extends GetxController {
  var historyList = <Reading>[].obs;
  RxBool isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getReadingHistory();
  }

  Future<void> getReadingHistory() async {
    try {
      isLoading(true);
      update();
      var userBox = Hive.box("userBox");
      String phone = userBox.get("phone");
      //  *************** API CALL *****************
      //List<Reading> readingsList = await RemoteServices().getReadingHistory(phone);

      // *************** from Local DB ******************
      List<Map<String, dynamic>>? res = await DatabaseHelper.getReadingHistory(phone);
      historyList.assignAll(res!.map((data) => Reading.fromJson(data)).toList());
    } catch (e) {
      showSnackbar(e.toString());
    } finally {
      isLoading(false);
      update();
    }
  }

  String getDiagnosisType(String type, int value) {
    if(type.toLowerCase().contains("before")) {
      if (value < 100) {
        return "Normal";
      } else if (value >= 100 && value <= 125) {
        return "Prediabetes";
      } else if (value > 125) {
        return "Diabetic";
      } else {
        return "Diabetic";
      }
    } else {
      if (value < 140) {
        return "Normal";
      } else if (value >= 140 && value <= 199) {
        return "Prediabetes";
      } else if (value > 200) {
        return "Diabetic";
      } else {
        return "Diabetic";
      }
    }
  }

  showSnackbar(String message, {bool isSuccess= false}) {
    Get.snackbar(
      "Required",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
      icon: Icon(
        isSuccess ? Icons.done : Icons.warning_amber_rounded,
        color: Colors.red,
      ),
    );
  }
}