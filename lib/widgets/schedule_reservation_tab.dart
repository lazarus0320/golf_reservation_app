import 'package:flutter/material.dart';

import '../widgets/ReservationPersonnelAndTimesetForm.dart';
import '../widgets/reservation_btn.dart';
import '../widgets/reservation_calendar_form2.dart';

class ScheduleReservationTab extends StatefulWidget {
  // 예약 주문일 지정 달력 폼
  ScheduleReservationTab({Key? key}) : super(key: key);

  @override
  _ScheduleReservationTabState createState() => _ScheduleReservationTabState();
}

class _ScheduleReservationTabState extends State<ScheduleReservationTab> {
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = ReservationCalendarForm2(); // Initialize with the first form
  }

  void switchPage(Widget newPage) {
    setState(() {
      currentPage = newPage;
    });
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
                final isBlack = currentPage is ReservationCalendarForm2
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
                          currentPage is ReservationCalendarForm2
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
                              switchPage(ReservationCalendarForm2());
                            },
                            backgroundColor: Colors.black,
                          ),
                          if (currentPage is ReservationPersonnelAndTimesetForm)
                            ReservationBtn(
                              btnText: '스케줄 등록',
                              onPressed: () {
                                // '스케줄 등록' 버튼을 눌렀을 때 실행될 동작 추가
                              },
                              backgroundColor: Colors.blue, // 파란색 배경
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