import 'package:get/get.dart';

class ScheduleController extends GetxController {
  var selectedStatus = 'Beroperasi Normal'.obs;
  var selectedChip = ''.obs;

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