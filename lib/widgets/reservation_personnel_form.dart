import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';

class ReservationPersonnelForm extends StatelessWidget {
  // 인원 정보 폼
  ReservationPersonnelForm({Key? key}) : super(key: key);
  final ReservationPersonnelController controller =
      Get.put(ReservationPersonnelController()); // 인원정보 컨트롤러 초기화

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '인원 선택',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(() => Radio<String>(
                  value: '3',
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.setSelectedValue(value!);
                  },
                )),
            const Text(
              '3명',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Obx(() => Radio<String>(
                  value: '4',
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.setSelectedValue(value!);
                  },
                )),
            const Text(
              '4명',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        )
      ],
    );
  }
}
