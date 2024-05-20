import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
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
      errorInvalidText: 'Waktu yang dimasukkan tidak cocok',
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
      days: List.from(selectedDays),
      openingTime: openingTime.value,
      closingTime: closingTime.value,
      is24Hours: is24Hours.value,
      isClosed: isClosedStatus.value,
    ));
    schedules.refresh();
  }

  void reset() {
    selectedDays.clear();
    openingTime.value = null;
    closingTime.value = null;
    is24Hours.value = false;
    isClosedStatus.value = false;
  }

   void updateScheduleStatus(int index, bool isActive) {
    if (index >= 0 && index < schedules.length) {
      schedules[index].isActive = isActive;
      schedules.refresh();
    }
  }
}

class Schedule {
  List<Day> days;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  bool is24Hours;
  bool isClosed;
  bool isActive;

  Schedule({
    required this.days,
    this.openingTime,
    this.closingTime,
    required this.is24Hours,
    required this.isClosed,
    this.isActive = true,
  });

  String formattedOpeningTime() {
    if (openingTime != null) {
      final dateTime = DateTime(1, 1, 1, openingTime!.hour, openingTime!.minute);
      return DateFormat.jm().format(dateTime);
    }
    return '';
  }

  String formattedClosingTime() {
    if (closingTime != null) {
      final dateTime = DateTime(1, 1, 1, closingTime!.hour, closingTime!.minute);
      return DateFormat.jm().format(dateTime);
    }
    return '';
  }
}


