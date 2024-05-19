import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/controller/bottomsheet_schedule_controller.dart';
import 'dart:developer';
import 'package:warmindo_admin_ui/pages/widget/custom_dropdown_multi.dart';

const List<Day> _dayItems = [
  Day('Senin'),
  Day('Selasa'),
  Day('Rabu'),
  Day('Kamis'),
  Day('Jumat'),
  Day('Sabtu'),
  Day('Minggu'),
];

class BottomSheetSchedule extends StatelessWidget {
  final BottomSheetScheduleController _controller = Get.put(BottomSheetScheduleController());

  BottomSheetSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        color: Colors.white60,
        width: screenWidth,
        height: screenHeight * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Hari'),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]),
              child: Obx(() {
                return CustomDropdown<Day>.multiSelect(
                  hintText: 'Pilih Hari',
                  items: _dayItems,
                  initialItems: _controller.selectedDays.toList(),
                  onListChanged: (value) {
                    log('changing value to: $value');
                    _controller.selectedDays.value = value;
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jam Buka'),
                      SizedBox(height: 10),
                      Obx(() {
                        return TextFormField(
                          onTap: () => _controller.chooseTime(context, true),
                          enabled: !(_controller.is24Hours.value || _controller.isClosedStatus.value),
                          readOnly: true,
                          controller: TextEditingController(
                            text: _controller.openingTime.value?.format(context) ?? '',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Misal: 08:00 AM',
                            suffixIcon: Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jam Tutup'),
                      SizedBox(height: 10),
                      Obx(() {
                        return TextFormField(
                          onTap: () => _controller.chooseTime(context, false),
                          enabled: !(_controller.is24Hours.value || _controller.isClosedStatus.value),
                          readOnly: true,
                          controller: TextEditingController(
                            text: _controller.closingTime.value?.format(context) ?? '',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Misal: 05:00 PM',
                            suffixIcon: Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Obx(() => Radio(
                            value: true,
                            groupValue: _controller.is24Hours.value,
                            onChanged: (value) => _controller.toggle24Hours(value),
                            activeColor: Colors.purple,
                          )),
                      Text('24 Jam'),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Row(
                    children: [
                      Obx(() => Radio(
                            value: true,
                            groupValue: _controller.isClosedStatus.value,
                            onChanged: (value) => _controller.toggleClosed(value),
                            activeColor: Colors.purple,
                          )),
                      Text('Close'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.09),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.reset();
                      log('Clear button clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, 
                      foregroundColor: Colors.white, 
                      minimumSize: Size(screenWidth / 2 - 30, 45),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), 
                      ),
                    ),
                    child: Text('Clear'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.addSchedule();
                      log('Save button clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Warna latar belakang tombol
                      foregroundColor: Colors.white, // Warna teks tombol
                      minimumSize: Size(screenWidth / 2 - 30, 45),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), 
                      ),
                    ),
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
