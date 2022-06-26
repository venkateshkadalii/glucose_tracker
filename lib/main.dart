import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_tracker/src/db_helper/db_helper.dart';
import 'package:glucose_tracker/src/modules/login/login_binding.dart';
import 'package:glucose_tracker/src/modules/login/login_page.dart';
import 'package:glucose_tracker/src/routes/route_config.dart';
import 'package:glucose_tracker/src/themes/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("userBox");
  await DatabaseHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      getPages : RouteConfig.getPages,
      initialBinding: LoginBinding(),
      //initialRoute: '/login',
      home: SplashScreenView(
        navigateRoute: LoginPage(),
        duration: 3000,
        imageSize: 130,
        imageSrc: "assets/splash.png",
        text: "GlucoTrack",
        textType: TextType.NormalText,
        textStyle: const TextStyle(
          fontSize: 30.0,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
