import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/db_helper/db_helper.dart';
import 'package:glucose_tracker/src/models/response_model.dart';
import 'package:glucose_tracker/src/models/user.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/services/remote_services.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  Future<void> doLogin(String phone, String password) async {
    try {
      isLoading(true);
      update();
      // api call
      //ResponseModel loginResponse = await RemoteServices.doLogin(username, password);
      // database call
      User? user = await DatabaseHelper.validateUser(phone: phone, password: password);
      if(user != null) {
        var userBox = Hive.box("userBox");
        userBox.put("phone", user.phone);
        userBox.put("firstname", user.firstName);
        Get.offAndToNamed(RouteConfig.home);
      } else {
        showSnackbar("Invalid phone number or password");
      }
    } catch(error) {
      showSnackbar(error.toString());
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

  togglePassword() {
    isPasswordVisible(!isPasswordVisible.value);
    update();
  }
}