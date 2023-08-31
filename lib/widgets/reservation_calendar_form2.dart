import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationCalendarForm2 extends StatelessWidget {
  // 예약 주문일 지정 달력 폼
  ReservationCalendarForm2({Key? key}) : super(key: key);

  final ReservationCalendarController _controller =
  Get.put(ReservationCalendarController());
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
        const SizedBox(height: 30),
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
                    focusedDay: value,
                    // firstDay: DateTime.now(), // 현재 날짜부터 선택 가능
                    firstDay: DateTime(2023), // 현재 날짜부터 선택 가능
                    lastDay: DateTime.now().add(const Duration(days: 365)), // 선택 가능한 최초 날짜
                    calendarFormat: CalendarFormat.month,
                    onDaySelected: (date, _) {
                      _controller.updateSelectedDate(date);
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
                  SizedBox(
                      child: ValueListenableBuilder<DateTime>(
                        valueListenable: selectedDate,
                        builder: (context, value, _) {
                          final selectedDayOfWeek = value.weekday;
                          final isWeekday =
                              selectedDayOfWeek >= 1 && selectedDayOfWeek <= 5;
                          final formattedFutureDate = dateFormat
                              .format(_controller.selectedFutureDate.value);

                          if (isWeekday && selectedDayOfWeek != 3) {
                            _controller.isWeekendSelected.value = false;
                            return Text(
                              '$formattedFutureDate 예약 접수',
                              style: const TextStyle(color: Colors.green),
                            );
                          } else if (selectedDayOfWeek == 3) {
                            _controller.isWeekendSelected.value = false;
                            // 수요일 선택의 경우
                            final formattedNextSaturday =
                            dateFormat.format(_controller.nextSaturday.value);
                            final formattedNextSunday =
                            dateFormat.format(_controller.nextSunday.value);

                            return Column(
                              children: [
                                Text(
                                  '우선순위 1: $formattedNextSaturday 예약 접수',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                Text(
                                  '우선순위 2: $formattedNextSunday 예약 접수',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                Text(
                                  '우선순위 3: $formattedFutureDate 예약 접수',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            );
                          } else {
                            _controller.isWeekendSelected.value = true;
                            return const Text('주말 예약 접수는 불가능합니다.');
                          }
                        },
                      )),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
