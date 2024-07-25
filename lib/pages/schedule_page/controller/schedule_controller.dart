import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/global/model/schedule_model.dart';

class ScheduleController extends GetxController {
  var isLoading = true.obs;
  var schedules = <Schedule>[].obs;
  var selectedStatus = 'Beroperasi Normal'.obs;
  var selectedChip = ''.obs;

  @override
  void onInit() {
    fetchScheduleList();
    super.onInit();
  }

  Future<void> fetchScheduleList() async {
    try {
      final response = await http.get(Uri.parse(ScheduleApi.getallScheduleList));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData is List) {
          schedules.value = responseData.map((json) => Schedule.fromJson(json)).toList();
          isLoading.value = false;
        } else {
          print('Received data format is not as expected.');
        }
      } else {
        print('Failed to fetch data. Response status: ${response.statusCode}');
      }
    } catch (error) {
      print("Error while fetching data: $error");
    } finally {
      print('Finished fetching data');
    }
  }
Future<void> updateStatusSchedule({
  required String isOpen,
  required String temporaryClosureDuration,
}) async {
  // Determine the actual values for `isOpen` and `temporaryClosureDuration`
  if (selectedStatus.value == 'Beroperasi Normal') {
    isOpen = '1'; // Open
    temporaryClosureDuration = ''; 
  } else if (selectedStatus.value == 'Tutup Sementara') {
    isOpen = '0'; // Closed
    temporaryClosureDuration = selectedChip.value; 
  } else if (selectedStatus.value == 'Tutup') {
    isOpen = '0'; // Closed
    temporaryClosureDuration = ''; 
  } else if (selectedStatus.value == 'Jadwal Khusus') {
    isOpen = '1'; // Assume it's open if it’s a special schedule
    // Set temporaryClosureDuration if needed
  }

  try {
    isLoading.value = true;
    var uri = Uri.parse('${ScheduleApi.updateSchedule}');
    var response = await http.put(
      uri,
      headers: {'Accept': 'application/json'},
      body: {
        'is_open': isOpen,
        'temporary_closure_duration': temporaryClosureDuration,
      },
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      print('Schedule updated successfully');
      print('Response: ${response.body}');
      Get.back(); 
    } else {
      isLoading.value = false;
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
    isLoading.value = false;
    print('Error occurred while updating schedule: $e');
    Get.snackbar(
      'Error',
      '$e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

// Future<void> updateStatusSchedule({
  // required String isOpen,
  // required String temporaryClosureDuration,
// }) async {
  // Determine the actual values for `isOpen` and `temporaryClosureDuration`
  // if (selectedStatus.value == 'Beroperasi Normal') {
    // isOpen = '1'; // Open
    // temporaryClosureDuration = ''; // Not needed for normal operation
  // } else if (selectedStatus.value == 'Tutup Sementara') {
    // isOpen = '0'; // Closed
    // temporaryClosureDuration = selectedChip.value; // Use selected chip value
  // } else if (selectedStatus.value == 'Tutup') {
    // isOpen = '0'; // Closed
    // temporaryClosureDuration = ''; // Not needed for permanent closure
  // } else if (selectedStatus.value == 'Jadwal Khusus') {
    // Custom logic for special schedule can be added here
    // Example:
    // isOpen = '1'; // Assume it's open if it’s a special schedule
    // temporaryClosureDuration can be a custom value if needed
//   }

//   try {
//     isLoading.value = true;
//     var uri = Uri.parse('${ScheduleApi.updateSchedule}');
//     var request = http.MultipartRequest('PUT', uri)
//       ..fields['is_open'] = isOpen
//       ..fields['temporary_closure_duration'] = temporaryClosureDuration
//       ..headers['Accept'] = 'application/json';

//     var response = await http.Response.fromStream(await request.send());

//     if (response.statusCode == 200) {
//       isLoading.value = false;
//       print('Schedule updated successfully');
//       print('Response: ${response.body}');
//       Get.back(); // Go back after a successful update
//     } else {
//       isLoading.value = false;
//       print('Failed to update schedule: ${response.statusCode}');
//       print('Response: ${response.body}');

//       Get.snackbar(
//         'Error',
//         'Failed to update schedule!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   } catch (e) {
//     isLoading.value = false;
//     print('Error occurred while updating schedule: $e');
//     Get.snackbar(
//       'Error',
//       '$e',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//     );
//   }
// }

  
  void updateScheduleStatusLocal(int index, bool newValue) {
    schedules[index].isOpen = newValue;
    schedules.refresh();
    // Optionally, you can make an API call to update the status on the server.
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

  Future<void> insertSchedule(Schedule schedule) async {
    // Implement insert schedule functionality here
  }
}
