import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown_multi.dart';

class BottomSheetScheduleController extends GetxController {
  var is24Hours = false.obs;
  var isClosedStatus = false.obs;
  var openingTime = Rx<TimeOfDay?>(null);
  var closingTime = Rx<TimeOfDay?>(null);
  var selectedDays = <Day>[].obs;
  var schedules = <Schedule>[].obs;

  void toggle24Hours(bool? value) {
    is24Hours.value = value ?? false;
    if (is24Hours.value) {
      isClosedStatus.value = false;
    }
  }

  void toggleClosed(bool? value) {
    isClosedStatus.value = value ?? false;
    if (isClosedStatus.value) {
      is24Hours.value = false;
    }
  }

  void chooseTime(BuildContext context, bool isOpening) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Masukkan Waktu',
      cancelText: 'Tutup',
      confirmText: 'Ok',
      hourLabelText: 'Jam',
      minuteLabelText: 'Menit',
      errorInvalidText: 'Waktu yang dimasukkan tidak cocok'
    );

    if (pickedTime != null) {
      if (isOpening) {
        openingTime.value = pickedTime;
      } else {
        closingTime.value = pickedTime;
      }
    }
  }

  void addSchedule() {
    schedules.add(Schedule(
      days: selectedDays,
      openingTime: openingTime.value,
      closingTime: closingTime.value,
      is24Hours: is24Hours.value,
      isClosed: isClosedStatus.value,
    ));
  }
}

class Schedule {
  List<Day> days;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  bool is24Hours;
  bool isClosed;

  Schedule({
    required this.days,
    this.openingTime,
    this.closingTime,
    required this.is24Hours,
    required this.isClosed,
  });
}

