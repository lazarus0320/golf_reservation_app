import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';

/// Flutter code sample for [AppBar].
class ReservationPersonnelForm2 extends StatelessWidget {
  ReservationPersonnelForm2({Key? key}) : super(key: key);

  final ReservationPersonnelController controller =
  Get.put(ReservationPersonnelController()); // 인원정보 컨트롤러 초기화

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '인원',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Obx(() => Radio<String>(
                value: '3',
                activeColor: Colors.black,
                groupValue: controller.selectedValue.value,
                onChanged: (value) {
                  controller.setSelectedValue(value!);
                },
              )),
            ),
            const Text('3명'),
            Padding(
              padding: const EdgeInsets.only(left: 150.0),
              child:
              Obx(() => Radio<String>(
                value:'4',
                activeColor: Colors.black,
                groupValue:controller.selectedValue.value,
                onChanged: (value) {
                  controller.setSelectedValue(value!);
                },
              )),
            ),
            const Text('4명'),
          ],
        ),
      ],
    );
  }
}
