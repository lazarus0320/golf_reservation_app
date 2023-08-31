import 'package:flutter/material.dart';

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
        body:
        const TabBarView(children:[
          Center(child : Text('DOGS')),
          Center(child : Text('CATS')),
          Center(child : Text('BIRDS'))
        ]
        ),
      ),
    );
  }
}
