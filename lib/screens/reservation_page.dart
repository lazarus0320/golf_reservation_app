import 'package:flutter/material.dart';
import 'package:golf_regist_app/widgets/schedule_reservation_tab.dart';

import '../widgets/schedule_check_cancel_tab.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          ScheduleReservationTab(),
          // Content for the '스케줄 조회/취소' tab (Page 2)
          ScheduleCheckCancelTab(),
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