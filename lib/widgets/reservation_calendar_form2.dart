import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/widgets/PriorityListTile.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class ReservationCalendarForm2 extends StatelessWidget {
// 예약 주문일 지정 달력 폼
  ReservationCalendarForm2({Key? key}) : super(key: key);

  final ReservationCalendarController controller =
  Get.find<ReservationCalendarController>();

  final ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  final DateFormat dateFormat = DateFormat('yy년 MM월 dd일 EEEE');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '예약일',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ValueListenableBuilder<DateTime>(
            valueListenable: selectedDate,
            builder: (context, value, _) {
              return Column(
                children: [
                  TableCalendar(
                    locale: 'ko_KR',
                    focusedDay: value,
                    firstDay: DateTime.now(), // 현재 날짜부터 선택 가능
// firstDay: DateTime(2023), // 현재 날짜부터 선택 가능
                    lastDay: DateTime.now().add(const Duration(days: 365)), // 선택 가능한 최초 날짜
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (date, _) {
                      controller.updateSelectedDate(date);
                      selectedDate.value = date;
                    },
                    calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.black),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (date) {
                      return isSameDay(date, selectedDate.value);
                    },
                    headerStyle: const HeaderStyle(

                      formatButtonVisible: false, // Remove the "2 weeks" button
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('우선순위',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ValueListenableBuilder<DateTime>(
                        valueListenable: selectedDate,
                        builder: (context, value, _) {
                          final selectedDayOfWeek = value.weekday;
                          final isWeekday =
                              selectedDayOfWeek >= 1 && selectedDayOfWeek <= 5;
                          final formattedFutureDate = controller.formattedNextFuture.value;

                          if (isWeekday && selectedDayOfWeek != 3) {
                            controller.isWeekendSelected.value = false;
                            return Column(
                              children: [
                                PriorityListTile(title: '$formattedFutureDate 예약 접수'),
                              ],
                            );
                          } else if (selectedDayOfWeek == 3) {
                              controller.isWeekendSelected.value = false;
                              // 수요일 선택의 경우
                              final formattedNextSaturday =
                              controller.formattedNextSaturday.value;
                              final formattedNextSunday =
                              controller.formattedNextSunday.value;

                              return Column(
                                children: [
                                  PriorityListTile(title:'$formattedFutureDate 예약 접수'),
                                  PriorityListTile(title:'$formattedNextSaturday 예약 접수'),
                                  PriorityListTile(title:'$formattedNextSunday 예약 접수'),
                                ],
                              );
                            } else { // 토, 일 선택시
                              controller.isWeekendSelected.value = true;
                              return const PriorityListTile(title:'주말에는 예약이 불가능합니다.');
                            }
                        }
                      )
              ]
                  ),
                      ]
              );
            }
          ))
      ],
    );
  }
}