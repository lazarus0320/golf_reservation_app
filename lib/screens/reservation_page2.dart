import 'package:flutter/material.dart';
import 'package:golf_regist_app/widgets/reservation_calendar_form2.dart';
import 'package:golf_regist_app/widgets/reservation_personnel_form2.dart';

/// Flutter code sample for [AppBar].
class ReservationPage2 extends StatelessWidget {
  const ReservationPage2({Key? key}) : super(key: key);

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
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [

                      const Text('골프장'),
                      Container(
                        width: 100.0,
                        margin: const EdgeInsets.only(left : 10.0), // 좌우 간격 조절
                        color: Colors.grey[200], // 배경색 지정
                        child:
                        TextField(
                          controller: TextEditingController(text:'드비치'), // 초기값 지정
                          enabled:false, // 수정 불가능하도록 설정
                          showCursor:false, // 커서 제거
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black, // 선택된 탭의 글자색
                  unselectedLabelColor: Colors.grey, // 선택되지 않은 탭의 글자색
                  tabs: [
                    Tab(text: '스케줄 예약', ),
                    Tab(text: '스케줄 조회/취소', ),
                    Tab(text:'예약 결과',),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children:[
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:ReservationPersonnelForm2()
                ),
                const SizedBox(height: 30,),
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:ReservationCalendarForm2()
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text('1')
            ]
          ),
          Column(
            children: [
              Text('1')
            ]
          )
        ],
      ),
      )
    );
  }
}
