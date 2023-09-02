import 'package:flutter/material.dart';

import '../widgets/ReservationPersonnelAndTimesetForm.dart';
import '../widgets/reservation_btn.dart';
import '../widgets/reservation_calendar_form2.dart';

class ReservationPage2 extends StatefulWidget {
  const ReservationPage2({Key? key}) : super(key: key);

  @override
  _ReservationPage2State createState() => _ReservationPage2State();
}

class _ReservationPage2State extends State<ReservationPage2>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    currentPage = ReservationCalendarForm2(); // Initialize with the first form
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void switchPage(Widget newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: '스케줄 예약'),
                  Tab(text: '스케줄 조회/취소'),
                  Tab(text: '예약 결과'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for the '스케줄 예약' tab (Page 1)
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List<Widget>.generate(2, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 15.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage is ReservationCalendarForm2
                              ? (index == 0 ? Colors.black : Colors.white)
                              : Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
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
                          child: currentPage is ReservationCalendarForm2
                              ? ReservationBtn(
                            btnText: '다음',
                            onPressed: () {
                              switchPage(
                                  ReservationPersonnelAndTimesetForm());
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Content for the '스케줄 조회/취소' tab (Page 2)
          Column(
            children: [
              // Add your content here for the second page of '스케줄 조회/취소' tab
            ],
          ),
          // Content for the '예약 결과' tab (Page 3)
          Column(
            children: [
              // Add your content here for the '예약 결과' tab
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: '임시'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: '로그아웃'),
        ],
        onTap: (index) {
          if (index == 0) {
            // 로그아웃 처리 코드를 여기에 작성하세요.
          }
        },
      ),
    );
  }
}