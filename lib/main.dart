import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller.dart';
import 'package:golf_regist_app/screens/login_page.dart';
// import 'package:golf_regist_app/screens/reservation_page.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:golf_regist_app/screens/reservation_page2.dart';
import 'package:golf_regist_app/screens/reservation_table_page.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'controller/reservation_timeset_controller2.dart';
import 'controller/reservation_timeset_controller3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        // Get.lazyPut<ReservationPersonnelController>(() => ReservationPersonnelController());
        Get.lazyPut<ReservationCalendarController>(() => ReservationCalendarController());
        Get.lazyPut<ReservationTimeSetController>(() => ReservationTimeSetController());
        Get.lazyPut<ReservationTimeSetController2>(() => ReservationTimeSetController2());
        Get.lazyPut<ReservationTimeSetController3>(() => ReservationTimeSetController3());
      }),
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
      ],


    );
  }
}