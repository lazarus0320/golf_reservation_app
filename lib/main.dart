import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:golf_regist_app/screens/login_page.dart';
import 'package:golf_regist_app/screens/reservation_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:golf_regist_app/screens/reservation_page2.dart';
import 'package:golf_regist_app/screens/reservation_table_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),
      title: 'Golf Reservation',
      theme: ThemeData(
          // Your app theme data
          ),
      initialRoute: '/reservation_page2',
      getPages: [
        GetPage(name: "/", page: () => LoginPage()),
        GetPage(name: "/reservation_page2", page: () => const ReservationPage2()),
        GetPage(name: "/reservation_table_page", page: () => const ReservationTablePage()),
      ]
    );
  }
}
