// 예약 시간 지정 폼
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golf_regist_app/controller/reservation_calendar_controller.dart';
import 'package:golf_regist_app/controller/reservation_personnel_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller2.dart';
import 'package:golf_regist_app/controller/reservation_timeset_controller3.dart';
import 'package:golf_regist_app/controller/time_priorities_controller.dart';
import 'package:golf_regist_app/widgets/reservation_personnel_form.dart';


class ReservationTimeSetForm extends StatefulWidget {
  const ReservationTimeSetForm({Key? key}) : super(key: key);
  @override
  _ReservationTimeSetFormState createState() => _ReservationTimeSetFormState();
}

class _ReservationTimeSetFormState extends State<ReservationTimeSetForm> {
  late final ReservationTimeSetController controller;
  late final ReservationTimeSetController2 controller2;
  late final ReservationTimeSetController3 controller3;
  late final ReservationCalendarController calendarController;
  late final TimePrioritiesController prioritiesController;
  // late final ReservationPersonnelController personnelController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ReservationTimeSetController>();
    controller2 = Get.find<ReservationTimeSetController2>();
    controller3 = Get.find<ReservationTimeSetController3>();

    // personnelController = Get.find<ReservationPersonnelController>();

    calendarController = Get.find<ReservationCalendarController>();
    prioritiesController =
        Get.put<TimePrioritiesController>(TimePrioritiesController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (calendarController.selectedFutureDate.value.weekday ==
                      3) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            // height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${calendarController.formattedNextFuture}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildCupertinoPicker(
                                        controller.amPmList,
                                        controller.selectedAmPm,
                                        controller.setSelectedAmPm,
                                      ),
                                      _buildCupertinoPicker(
                                        controller.hourList,
                                        controller.selectedHour,
                                        controller.setSelectedHour,
                                      ),
                                      _buildCupertinoPicker(
                                        controller.minuteList,
                                        controller.selectedMinute,
                                        controller.setSelectedMinute,
                                      ),
                                    ],
                                  ),
                                  ReservationPersonnelForm(controller: Get.put(ReservationPersonnelController()), tag: 'container'),
                                ],

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          // height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${calendarController.formattedNextSaturday}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildCupertinoPicker(
                                        controller2.amPmList,
                                        controller2.selectedAmPm,
                                        controller2.setSelectedAmPm),
                                    _buildCupertinoPicker(
                                        controller2.hourList,
                                        controller2.selectedHour,
                                        controller2.setSelectedHour),
                                    _buildCupertinoPicker(
                                        controller2.minuteList,
                                        controller2.selectedMinute,
                                        controller2.setSelectedMinute),
                                  ],
                                ),
                                ReservationPersonnelForm(controller: Get.put(ReservationPersonnelController()), tag: 'container2'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          // height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${calendarController.formattedNextSunday}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildCupertinoPicker(
                                          controller3.amPmList,
                                          controller3.selectedAmPm,
                                          controller3.setSelectedAmPm),
                                      _buildCupertinoPicker(
                                          controller3.hourList,
                                          controller3.selectedHour,
                                          controller3.setSelectedHour),
                                      _buildCupertinoPicker(
                                          controller3.minuteList,
                                          controller3.selectedMinute,
                                          controller3.setSelectedMinute),
                                    ],
                                  ),
                                  ReservationPersonnelForm(controller: Get.put(ReservationPersonnelController()), tag: 'container3'),
                                ]),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  } else {
                    return Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${calendarController.formattedNextFuture}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildCupertinoPicker(
                                      controller.amPmList,
                                      controller.selectedAmPm,
                                      controller.setSelectedAmPm),
                                  _buildCupertinoPicker(
                                      controller.hourList,
                                      controller.selectedHour,
                                      controller.setSelectedHour),
                                  _buildCupertinoPicker(
                                      controller.minuteList,
                                      controller.selectedMinute,
                                      controller.setSelectedMinute),
                                ],
                              ),
                              ReservationPersonnelForm(controller: Get.put(ReservationPersonnelController()), tag: 'container'),
                            ]));
                  }
                }),
              ),
            ))
      ],
    );
  }

  Widget _buildCupertinoPicker(List<String> itemList, RxString selectedItem,
      Function(String) setSelectedItem) {
    return Expanded(
      child: Obx(
        () => CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: itemList.indexOf(selectedItem.value),
          ),
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setSelectedItem(itemList[index]);
          },
          children: itemList.map((String item) {
            return Text(
              item,
              style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            );
          }).toList(),
        ),
      ),
    );
  }
}
