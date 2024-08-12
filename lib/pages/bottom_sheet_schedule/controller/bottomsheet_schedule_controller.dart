import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/model_schedule.dart';
import 'package:warmindo_admin_ui/global/widget/custom_dropdown_multi.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/pages/schedule_page/controller/schedule_controller.dart';

class BottomSheetScheduleController extends GetxController {
  final ScheduleController scheduleController = Get.put(ScheduleController());
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  var is24Hours = false.obs;
  var isClosedStatus = false.obs;
  var openingTime = Rx<TimeOfDay?>(null);
  var closingTime = Rx<TimeOfDay?>(null);
  var selectedDays = <Day>[].obs;
  var schedules = <Schedule>[].obs;
  var isLoading = true.obs;

  TimeOfDay parseTimeOfDay(String time) {
    final format = DateFormat.Hm(); // format jam dan menit
    return TimeOfDay.fromDateTime(format.parse(time));
  }

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
      String formattedTime = pickedTime.format(context); // format lokal H:i

      if (isOpening) {
        openingTime.value = pickedTime;
        openTimeController.text = formattedTime;
      } else {
        closingTime.value = pickedTime;
        closeTimeController.text = formattedTime;
      }
    }
  }

  String formatTimeOfDayWithSeconds(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    const seconds = '00';

    return '$hours:$minutes:$seconds';
  }

  Future<void> updateScheduleTime({
    required String id,
    String? start_time,
    String? end_time,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${ScheduleApi.updateSchedule}$id?_method=PUT');
      
      // Tentukan waktu mulai dan akhir berdasarkan kondisi is24Hours dan isClosedStatus
      String formattedStartTime;
      String formattedEndTime;

      if (is24Hours.value) {
        formattedStartTime = '00:00:00';
        formattedEndTime = '23:59:59';
      } else if (isClosedStatus.value) {
        formattedStartTime = '00:00:00';
        formattedEndTime = '00:00:00';
      } else {
        TimeOfDay? startTime = openingTime.value;
        TimeOfDay? endTime = closingTime.value;

        if (startTime == null || endTime == null) {
          Get.snackbar(
            'Error',
            'Start time or end time is missing!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        // Format menjadi string H:i:s
        formattedStartTime = formatTimeOfDayWithSeconds(startTime);
        formattedEndTime = formatTimeOfDayWithSeconds(endTime);
      }

      Map<String, String> body = {
        'start_time': formattedStartTime,
        'end_time': formattedEndTime,
      };

      print('Start Time: $formattedStartTime');
      print('End Time: $formattedEndTime');
      print(id);

      var response = await http.post(
        uri,
        headers: {'Accept': 'application/json'},
        body: body,
      );
      
      if (response.statusCode == 200) {
        print('Schedule Time Update Success');
        print('Response: ${response.body}');
        await scheduleController.fetchScheduleList();
        reset();
        Get.back();
      } else {
        print('Failed to update schedule time: ${response.statusCode}');
        print('Response: ${response.body}');
        Get.snackbar(
          'Error',
          'Failed to update schedule time!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error occurred while updating schedule time: $e');
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    selectedDays.clear();
    openingTime.value = null;
    closingTime.value = null;
    is24Hours.value = false;
    isClosedStatus.value = false;
  }
}
