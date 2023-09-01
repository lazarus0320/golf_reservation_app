import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/widgets/PriorityListTile.dart';
import 'package:golf_regist_app/widgets/reservation_btn.dart';
import 'package:golf_regist_app/widgets/reservation_calendar_form2.dart';
import 'package:golf_regist_app/widgets/reservation_timeset_form.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class ReservationPersonnelAndTimesetForm extends StatelessWidget {
  // 예약 주문일 지정 달력 폼
  ReservationPersonnelAndTimesetForm({Key? key}) : super(key: key);

  final ReservationCalendarController controller =
  Get.find<ReservationCalendarController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('매크로 진행일'),
            Container(
              width: 200.0,
              margin: const EdgeInsets.only(left: 10.0), // 좌우 간격 조절
              color: Colors.grey[200], // 배경색 지정
              child: TextField(
                controller:
                TextEditingController(text: '${controller.formattedSelectedDay}'), // 초기값 지정
                enabled: false, // 수정 불가능하도록 설정
                showCursor: false, // 커서 제거
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30,),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '예약 시간',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const ReservationTimeSetForm(),
      ],
    );
  }
}

class ReservationPage2 extends StatefulWidget {
  const ReservationPage2({Key? key}) : super(key: key);

  @override
  _ReservationPage2State createState() => _ReservationPage2State();
}

class _ReservationPage2State extends State<ReservationPage2> {
  final PageController _pageController = PageController(initialPage: 0); // PageController 추가

  @override
  void dispose() {
    _pageController.dispose(); // PageController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('골프 스케줄 예약/취소'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      const Text('골프장'),
                      Container(
                        width: 100.0,
                        margin: const EdgeInsets.only(left: 10.0),
                        color: Colors.grey[200],
                        child: TextField(
                          controller: TextEditingController(text: '드비치'),
                          enabled: false,
                          showCursor: false,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: '스케줄 예약',),
                    Tab(text: '스케줄 조회/취소',),
                    Tab(text: '예약 결과',),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: index == 0 ? ReservationCalendarForm2() : ReservationPersonnelAndTimesetForm(),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter, // 아래쪽 정렬
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // 아래 여백 추가
                    child: index == 0
                        ? ReservationBtn(
                      btnText: '다음',
                      onPressed: () {
                        setState(() {
                          _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        });
                      },
                      backgroundColor: Colors.black,
                    )
                        : ReservationBtn(
                      btnText: '이전',
                      onPressed: () {
                        setState(() {
                          _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        });
                      },
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: '임시',),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: '로그아웃',),
          ],
          onTap: (index) {
            if (index == 0) {
              // 로그아웃 처리 코드를 여기에 작성하세요.
            }
          },
        ),
      ),
    );
  }
}
