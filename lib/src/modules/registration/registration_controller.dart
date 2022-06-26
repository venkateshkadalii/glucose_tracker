import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/db_helper/db_helper.dart';
import 'package:glucose_tracker/src/models/response_model.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/services/remote_services.dart';

import '../../models/user.dart';

class RegistrationController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  Future<int> addToDatabase(User user) async {
    return await DatabaseHelper.insertUser(user);
  }

  Future<void> saveUser(User user) async {
    try {
      isLoading(true);
      update();
      // api call
      /*ResponseModel responseModel = await RemoteServices().registerUser(user.firstName ?? '', user.lastName ?? '', user.age ?? 0, user.gender ?? '', user.password ?? '', user.phone??');
      if (responseModel.isSuccessful!) {
        // code
      } else {
        // snack bar
      }*/

      // saving to local db
      int result = await addToDatabase(user);
      if (result > 0) {
        showSnackbar("User saved successfully", isSuccess: true);
        Get.toNamed(RouteConfig.login);
      } else {
        showSnackbar("Something went wrong");
      }
    } catch (e) {
      print("=========> $e");
    } finally {
      isLoading(false);
      update();
    }
  }

  togglePasswordVisibility() {
    isPasswordVisible(!isPasswordVisible.value);
    update();
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