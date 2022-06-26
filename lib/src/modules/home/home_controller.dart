import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  toggleTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    isDarkTheme(Get.isDarkMode ? true : false);
    update();
  }

  logout() {
    Hive.box("userBox").clear();
    Get.offAndToNamed(RouteConfig.login);
  }
}