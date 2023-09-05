import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationResultTab extends StatefulWidget {
  ReservationResultTab({Key? key}) : super(key: key);

  @override
  _ReservationResultTabState createState() => _ReservationResultTabState();
}

class _ReservationResultTabState extends State<ReservationResultTab> {
  List<Map<String, dynamic>> resultLogData = [];

  @override
  void initState() {
    super.initState();
    _fetchResultLogData();
  }

  Future<void> _fetchResultLogData() async {
    try {
      final response = await http.get(
        Uri.parse("http://61.83.77.86:5000/reservation_table"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        resultLogData = jsonData['resultLogData'].cast<Map<String, dynamic>>();

        debugPrint('Received data from server:');
        debugPrint(resultLogData.toString());
      } else {
        debugPrint('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String selectedBtn = '1주일';

  void selectBtn(String btnText) {
    setState(() {
      selectedBtn = btnText;
    });
  }

  String selectedSortOption = '최근일자순';

  void selectSortOption(String option) {
    setState(() {
      selectedSortOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('당일'),
                    style: ElevatedButton.styleFrom(
                      primary:
                      selectedBtn == '당일' ? Colors.green : Colors.white,
                      onPrimary:
                      selectedBtn == '당일' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                        selectedBtn == '당일' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text('당일'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('1주일'),
                    style: ElevatedButton.styleFrom(
                      primary:
                      selectedBtn == '1주일' ? Colors.green : Colors.white,
                      onPrimary:
                      selectedBtn == '1주일' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                        selectedBtn == '1주일' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text('1주일'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () => selectBtn('1개월'),
                    style: ElevatedButton.styleFrom(
                      primary:
                      selectedBtn == '1개월' ? Colors.green : Colors.white,
                      onPrimary:
                      selectedBtn == '1개월' ? Colors.white : Colors.black,
                      side: BorderSide(
                        color:
                        selectedBtn == '1개월' ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text('1개월'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${resultLogData.length}건',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  PopupMenuButton<String>(
                    onSelected: selectSortOption,
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: '최근일자순',
                        child: Text('최근일자순'),
                      ),
                      const PopupMenuItem<String>(
                        value: '오래된순',
                        child: Text('오래된순'),
                      )
                    ],
                    child: Row(
                      children: [
                        Text('정렬: $selectedSortOption'),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: resultLogData.length,
              itemBuilder: (context, index) {
                final data = resultLogData[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Log: ${data['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          // Add a divider here
                          height: 20,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Text('스케줄 등록일시: ${data['selectedDay']}'),
                        Text('인원: ${data['personnel']}'),
                        Text(
                            '예약일시: ${data['nextFuture']} ${data['futureTime']}'),
                        Text('결과: ${data['result']}'),
                        Text('코스: ${data['course']}'),
                        Text('티업시간: ${data['teeUpTime']}'),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
