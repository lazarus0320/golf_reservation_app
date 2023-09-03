import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleCheckCancelTab extends StatefulWidget {
  ScheduleCheckCancelTab({Key? key}) : super(key: key);

  @override
  _ScheduleCheckCancelTabState createState() => _ScheduleCheckCancelTabState();
}

class _ScheduleCheckCancelTabState extends State<ScheduleCheckCancelTab> {
  List<Map<String, dynamic>> reservationData = [];

  @override
  void initState() {
    super.initState();
    _fetchReservationData();
  }

  Future<void> _fetchReservationData() async {
    try {
      final response = await http.get(
        Uri.parse("http://61.83.77.86:5000/reservation_table"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        reservationData = jsonData['reservations'].cast<Map<String, dynamic>>();
        setState(() {});

        debugPrint('Received data from server:');
        debugPrint(reservationData.toString());
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _showCancelConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Center(child: Text('스케줄 취소')),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.warning, color: Colors.red, size: 48.0),
              SizedBox(height: 20),
              Text(
                '해당 스케줄 예약을 취소하시겠습니까?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '취소',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _cancelReservation(id);
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelReservation(int id) async { // 예약 취소 기능
    try {
      final response = await http.delete(
        // Uri.parse("${dotenv.env['BASEURL']}/reservation_cancel/$id"),
        Uri.parse("http://61.83.77.86:5000/reservation_cancel/$id"),
      );

      if (response.statusCode == 200) {
        // Reservation canceled successfully, you can handle the response if needed
        debugPrint('Reservation canceled for ID: $id');
        _fetchReservationData(); // Refresh the reservation data after cancellation
      } else {
        // Handle HTTP error (status code other than 200)
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors, such as network error
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: reservationData.length,
                itemBuilder: (context, index) {
                  final reservation = reservationData[index];
                  final String scheduleRegistrationTime =
                      '${reservation['selectedDay']}   09:00';

                  final String reservationTimeWeekday =
                      '${reservation['nextFuture']}    ${reservation['futureTime']}            인원: ${reservation['personnel']}';

                  final String reservationTimeSaturday =
                      '${reservation['nextSaturday']}    ${reservation['saturdayTime']}            인원: ${reservation['personnel']}';

                  final String reservationTimeSunday =
                      '${reservation['nextSunday']}    ${reservation['sundayTime']}            인원: ${reservation['personnel']}';

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '스케줄 등록 일시: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(scheduleRegistrationTime),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _showCancelConfirmationDialog(reservation['id']);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '예약 일시 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(reservationTimeWeekday),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '예약 일시 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(reservationTimeSaturday),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '예약 일시 : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(reservationTimeSunday),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}