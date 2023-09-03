import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationPersonnelController2 extends GetxController {
  // 인원 정보 컨트롤러
  RxString selectedValue = '3'.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    ever(selectedValue, (_) {
      debugPrint('Selected Value: ${selectedValue.value}');
    });
  }
}
