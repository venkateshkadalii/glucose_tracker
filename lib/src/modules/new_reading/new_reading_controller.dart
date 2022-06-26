import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/db_helper/db_helper.dart';
import 'package:glucose_tracker/src/models/reading.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/services/remote_services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../models/response_model.dart';

class NewReadingController extends GetxController {
  RxBool isLoading = false.obs;


  Future<void> saveEntry({required String type, required int value}) async {
    try {
      isLoading(true);
      update();
      String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
      var userBox = Hive.box("userBox");
      String phone = userBox.get("phone");

      // API call
      //ResponseModel response = await RemoteServices().saveReading(date, type, value);

      // Local db
      int result = await DatabaseHelper.insertReading(Reading(type: type, value: value, date: date, phone: phone));
      if(result > 0) {
        showSnackbar("Entry saved successfully", isSuccess: true);
        Get.offAndToNamed(RouteConfig.home);
      } else {
        showSnackbar("Something went wrong!",);
      }
    } catch(e) {
      showSnackbar(e.toString());
    } finally {
      isLoading(false);
      update();
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