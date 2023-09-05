import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/login_controller.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../controller/reservation_calendar_controller.dart';
import '../controller/reservation_timeset_controller2.dart';
import '../controller/reservation_timeset_controller3.dart';
import '../widgets/ReservationPersonnelAndTimesetForm.dart';
import '../widgets/reservation_btn.dart';
import '../widgets/reservation_calendar_form.dart';

class ScheduleReservationTab extends StatefulWidget {
  // 예약 주문일 지정 달력 폼
  ScheduleReservationTab({Key? key}) : super(key: key);

  @override
  _ScheduleReservationTabState createState() => _ScheduleReservationTabState();
}

class _ScheduleReservationTabState extends State<ScheduleReservationTab> {
  late Widget currentPage;
  final ReservationCalendarController calendarController = Get.find<ReservationCalendarController>();
  final LoginController loginController = Get.find<LoginController>();
  final ReservationPersonnelController personnelController = Get.find<ReservationPersonnelController>();
  final ReservationTimeSetController timeSetController = Get.find<ReservationTimeSetController>();
  final ReservationTimeSetController2 timeSetController2 = Get.find<ReservationTimeSetController2>();
  final ReservationTimeSetController3 timeSetController3 = Get.find<ReservationTimeSetController3>();
  @override
  void initState() {
    super.initState();
    currentPage = ReservationCalendarForm(); // Initialize with the first form
  }

  void switchPage(Widget newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  Future<void> _submit(BuildContext context) async {
    if (calendarController.isWeekendSelected.value) {
      Get.snackbar('notice', '주말 예약 접수는 불가능합니다.');
      return;
    }

    try {
    final response = await http.post(
        Uri.parse("http://61.83.77.86:5000/reservation"),
        body: {
          'id': loginController.id,
          'pw': loginController.pw,
          'personnel': personnelController.getSelectedValue('container').toString(),
          'selectedDay': calendarController.formattedSelectedDay.toString(),
          'nextFuture': calendarController.formattedNextFuture.value,
          'futureTime': timeSetController.formattedTime,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('예약 접수 완료');
        Get.snackbar('notice', '스케줄 예약이 완료되었습니다.');
      }
      else if (response.statusCode == 500) {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
      else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
    }
    catch (e) {
      Get.snackbar('notice', '예약 실패..');
    }
  }

  Future<void> _submit2(BuildContext context) async {
    if (calendarController.isWeekendSelected.value) {
      Get.snackbar('notice', '주말 예약 접수는 불가능합니다.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://61.83.77.86:5000/reservation"),
        body: {
          'id': loginController.id,
          'pw': loginController.pw,
          'personnel': personnelController.getSelectedValue('container2').toString(),
          'selectedDay': calendarController.formattedSelectedDay.toString(),
          'nextFuture': calendarController.formattedNextSaturday.value,
          'futureTime': timeSetController2.formattedTime,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('예약 접수 완료');
        Get.snackbar('notice', '스케줄 예약이 완료되었습니다.');
      }
      else if (response.statusCode == 500) {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
      else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
    }
    catch (e) {
      Get.snackbar('notice', '예약 실패..');
    }
  }

  Future<void> _submit3(BuildContext context) async {
    if (calendarController.isWeekendSelected.value) {
      Get.snackbar('notice', '주말 예약 접수는 불가능합니다.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://61.83.77.86:5000/reservation"),
        body: {
          'id': loginController.id,
          'pw': loginController.pw,
          'personnel': personnelController.getSelectedValue('container3').toString(),
          'selectedDay': calendarController.formattedSelectedDay.toString(),
          'nextFuture': calendarController.formattedNextSaturday.value,
          'futureTime': timeSetController3.formattedTime,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('예약 접수 완료');
        Get.snackbar('notice', '스케줄 예약이 완료되었습니다.');
      }
      else if (response.statusCode == 500) {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
      else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        Get.snackbar('notice', errorMessage);
      }
    }
    catch (e) {
      Get.snackbar('notice', '예약 실패..');
    }
  }

  Future<void> _submitAll(BuildContext context) async {
    await Future.wait([
      _submit(context),
      _submit2(context),
      _submit3(context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List<Widget>.generate(2, (index) {
                final isBlack = currentPage is ReservationCalendarForm
                    ? (index == 0 ? true : false)
                    : true; // Check if the circle color is black
                final circleColor = isBlack ? Colors.black : Colors.white;
                final textColor = isBlack ? Colors.white : Colors.black;

                return Stack(
                    children: [
                      Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                        child: Center(
                          child: Text((index + 1).toString(),
                            style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30,),
                    ]
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: currentPage,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: [
                          currentPage is ReservationCalendarForm
                              ? ReservationBtn(
                            btnText: '다음',
                            onPressed: () {
                              switchPage(ReservationPersonnelAndTimesetForm());
                            },
                            backgroundColor: Colors.black,
                          )
                              : ReservationBtn(
                            btnText: '이전',
                            onPressed: () {
                              switchPage(ReservationCalendarForm());
                            },
                            backgroundColor: Colors.black,
                          ),
                          if (currentPage is ReservationPersonnelAndTimesetForm)
                            ReservationBtn(
                                btnText: '스케줄 등록',
                                onPressed: () {
                                  if (calendarController.selectedDate.value.weekday == 3) {
                                    _submitAll(context);
                                  }
                                  else {
                                    _submit(context);
                                  }
                                },
                                backgroundColor: Colors.green,
                            ),
                          ],
                      ),
                      ),
                    ),
                ]
            ),
          ),
        ),
      ],
    );
  }
}