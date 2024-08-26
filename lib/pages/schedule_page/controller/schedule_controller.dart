import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:warmindo_admin_ui/global/model/model_schedule.dart';

class ScheduleController extends GetxController {
  late final tz.Location asiaJakarta;
  late final tz.TZDateTime now;
  late final String today;
  RxList<ScheduleList> scheduleElement = <ScheduleList>[].obs;
  List<ScheduleList> jadwalElement = <ScheduleList>[];
  var isLoading = true.obs;
  var selectedStatus = 'Beroperasi Normal'.obs;
  var selectedChip = ''.obs;
  var scheduleId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null).then((_) {
      tz.initializeTimeZones();
      asiaJakarta = tz.getLocation('Asia/Jakarta');
      now = tz.TZDateTime.now(asiaJakarta);
      today = DateFormat('EEEE', 'id_ID').format(now);

      fetchScheduleList();
    }).catchError((e) {
      print('Error initializing date formatting: $e');
    });
  }

  Future<void> fetchScheduleList() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse(ScheduleApi.getallScheduleList));
      if (response.statusCode == 200) {
        scheduleElement.value = scheduleListFromJson(response.body);
        final List<ScheduleList> todaySchedule = scheduleElement
            .where((schedule) => schedule.days == today)
            .toList();
        jadwalElement = todaySchedule;
        scheduleId.value = jadwalElement[0].id;
        print('Schedule fetched successfully');
        print('Response: ${response.body}');
      } else {
        print('Failed to fetch schedule: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching schedule: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatusSchedule({
    String? temporaryClosureDuration,
    String? end_time,
    String? start_time,
  }) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse('${ScheduleApi.updateSchedule}${scheduleId.value}?_method=PUT');

      Map<String, String> body = {};
      if (start_time != null) body['start_time'] = start_time;
      if (end_time != null) body['end_time'] = end_time;
      if (temporaryClosureDuration != null) body['temporary_closure_duration'] = temporaryClosureDuration;

      var response = await http.post(
        uri,
        headers: {'Accept': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Schedule updated successfully');
        print('Response: ${response.body}');
        await fetchScheduleList();
        Get.back();
      } else {
        print('Failed to update schedule: ${response.statusCode}');
        print('Response: ${response.body}');
        Get.snackbar(
          'Error',
          'Failed to update schedule!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error occurred while updating schedule: $e');
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setStatus(String status) {
    selectedStatus.value = status;
  }

  void setChip(String chip) {
    selectedChip.value = chip;
  }

  void resetChip() {
    selectedChip.value = '';
  }
}


