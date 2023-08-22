import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller2.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller3.dart';
import 'package:intl/intl.dart';
import '../controller/login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:golf_regist_app/widgets/reservation_btn.dart';
import 'package:golf_regist_app/widgets/reservation_personnel_form.dart';
import 'package:golf_regist_app/widgets/login_form.dart';
import 'package:golf_regist_app/widgets/reservation_calendar_form.dart';
import 'package:golf_regist_app/widgets/reservation_timeset_form.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReservationPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final ReservationPersonnelController personnelController =
      Get.put(ReservationPersonnelController());
  final ReservationCalendarController calendarController =
      Get.put(ReservationCalendarController());
  final ReservationTimeSetController timeSetController1 =
      Get.put(ReservationTimeSetController());
  final ReservationTimeSetController2 timeSetController2 =
      Get.put(ReservationTimeSetController2());
  final ReservationTimeSetController3 timeSetController3 =
      Get.put(ReservationTimeSetController3());

  Future<void> _submit(BuildContext context) async {
    if (calendarController.isWeekendSelected.value) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('주말 예약 접수는 불가능합니다.')));
      Get.snackbar("notice", '주말 예약 접수는 불가능합니다.');
      return;
    }

    final formattedSelectedDay = DateFormat('yyyy-MM-dd').format(calendarController.selectedDate.value);
    // final startTime = DateTime.now(); // 시간 측정 시작
    try {
      debugPrint(
        'id: ${loginController.id}, pw: ${loginController
            .pw}, personnel: ${personnelController.selectedValue}',
      );
      final response = await http.post(
        // Uri.parse("${dotenv.env['BASEURL']}/reservation"),
        // 단순 예약 테스트의 경우 /login으로 변경 /reservation
        Uri.parse("http://192.168.123.70:5000/reservation"), // 웹 버전의 경우..
        body: {
          'id': loginController.id,
          'pw': loginController.pw,
          'personnel': personnelController.selectedValue.value,
          'selectedDay' : formattedSelectedDay.toString(),
          'nextFuture': calendarController.formattedNextFuture.value,
          'nextSaturday': calendarController.formattedNextSaturday.value,
          'nextSunday': calendarController.formattedNextSunday.value,
          'futureTime': timeSetController1.formattedTime,
          'saturdayTime': timeSetController2.formattedTime,
          'sundayTime': timeSetController3.formattedTime,
          'wednesdayCheck':
          calendarController.selectedFutureDate.value.weekday.toString(),
        },
      );
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Login successful');
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text('예약 주문이 접수되었습니다.')
        //     )
        // );
        Get.snackbar('notice', '예약 주문이 접수되었습니다.');
      }
      else if (response.statusCode == 500) {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(errorMessage)),
        // );
        Get.snackbar("notice", errorMessage);

      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(errorMessage)),
        // );
        Get.snackbar("notice", errorMessage);
      }
    }
    catch (e) {
      debugPrint('Exception occurred: $e');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('예약 실패..')));
      Get.snackbar("notice", "예약 실패..");
    }

    //     final elapsedTimeDouble = jsonDecode(response.body);
    //     final elapsedTime = elapsedTimeDouble.toStringAsFixed(4);
    //     // final elapsedTime = responseData['elapsed_time'];
    //
    //     debugPrint('Login successful');
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(
    //         SnackBar(
    //             content: GestureDetector(
    //               onTap: () {
    //                 launchUrl(Uri.parse('https://www.debeach.co.kr/booking/history'));
    //               },
    //             child: Text('예약 성공! 소요시간: $elapsedTime 예약 정보 확인하기 : https://www.debeach.co.kr/booking/history')
    //             )
    //         ));
    //   } else if (response.statusCode == 500) {
    //     final responseData = jsonDecode(response.body);
    //     final errorMessage = responseData['error'];
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(errorMessage)),
    //     );
    //   } else {
    //     final responseData = jsonDecode(response.body);
    //     final errorMessage = responseData['error'];
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(errorMessage)),
    //     );
    //   }
    // } catch (e) {
    //   debugPrint('Exception occurred: $e');
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('예약 실패..')));
    // }
  }

  Container buildStyledContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF26262A),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(children: <Widget>[
          // buildStyledContainer(LoginForm()),
          buildStyledContainer(ReservationPersonnelForm()),
          buildStyledContainer(ReservationCalendarForm()),
          buildStyledContainer(const ReservationTimeSetForm()),
          ReservationBtn(
            btnText: '예약하기',
            onPressed: () => _submit(context),
            backgroundColor: Colors.red,
          ),
          ReservationBtn(
            btnText: '예약 목록 조회',
            onPressed: () {
              Get.toNamed('/reservation_table_page');
            },
            backgroundColor: Color(0xFF69DB7C),
          )
        ]));
  }
}
