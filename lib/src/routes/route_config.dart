import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:glucose_tracker/src/modules/home/home_binding.dart';
import 'package:glucose_tracker/src/modules/home/home_page.dart';
import 'package:glucose_tracker/src/modules/login/login_binding.dart';
import 'package:glucose_tracker/src/modules/login/login_page.dart';
import 'package:glucose_tracker/src/modules/new_reading/new_reading_binding.dart';
import 'package:glucose_tracker/src/modules/new_reading/new_reading_page.dart';
import 'package:glucose_tracker/src/modules/reading_history/readinghistory_binding.dart';
import 'package:glucose_tracker/src/modules/reading_history/readinghistory_page.dart';
import 'package:glucose_tracker/src/modules/registration/registration_binding.dart';
import 'package:glucose_tracker/src/modules/registration/registration_page.dart';

class RouteConfig {

  static const String login = '/login';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String addreading = '/addreading';
  static const String readinghistory = '/history';

  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: registration, page: () => RegistrationPage(), binding: RegistrationBinding()),
    GetPage(name: home, page: () => const HomePage(), binding: HomeBinding()),
    GetPage(name: addreading, page: () => AddNewReading(), binding: NewReadingBinding()),
    GetPage(name: readinghistory, page: () => const ReadingHistoryPage(), binding: ReadingHistoryBinding()),
  ];
}