import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glucose_tracker/src/modules/home/home_controller.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/widgets/app_text_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glucose Tracker"),
        actions: [
          GetX<HomeController>(builder: (controller) {
            return IconButton(
                icon: controller.isDarkTheme.value
                    ? const Icon(Icons.wb_sunny_outlined)
                    : const Icon(Icons.sunny),
                onPressed: () => controller.toggleTheme(),
            );
          }),
          GetBuilder<HomeController>(
            builder: (controller) {
              return IconButton(onPressed: () => controller.logout(), icon: const Icon(Icons.exit_to_app));
            }
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.addreading);
                },
                buttonText: "ADD NEW READING",
                backgroundColor: Theme.of(context).primaryColor),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            AppTextButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.readinghistory);
                },
                buttonText: "VIEW READINGS HISTORY",
                backgroundColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
