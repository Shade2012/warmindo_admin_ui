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
  final BottomSheetScheduleController _controller =
      Get.put(BottomSheetScheduleController());

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
        height: screenHeight * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Hari'),
            SizedBox(height: 10),
            Container(
              child: CustomDropdown<Day>.multiSelect(
                items: _dayItems,
                initialItems: _dayItems.take(1).toList(),
                onListChanged: (value) {
                  log('changing value to: $value');
                  _controller.selectedDays.value = value;
                },
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]),
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
                          enabled: !(_controller.is24Hours.value ||
                              _controller.isClosedStatus.value),
                          readOnly: true,
                          controller: TextEditingController(
                            text: _controller.openingTime.value
                                    ?.format(context) ??
                                '',
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
                          enabled: !(_controller.is24Hours.value ||
                              _controller.isClosedStatus.value),
                          readOnly: true,
                          controller: TextEditingController(
                            text: _controller.closingTime.value
                                    ?.format(context) ??
                                '',
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
                            onChanged: _controller.toggle24Hours,
                            activeColor: Colors.purple,
                          )),
                      Text('24 Jam'),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                    children: [
                      Obx(() => Radio(
                            value: true,
                            groupValue: _controller.isClosedStatus.value,
                            onChanged: _controller.toggleClosed,
                            activeColor: Colors.purple,
                          )),
                      Text('Close'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _controller.addSchedule(); // Add this line
                  log('Button clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna latar belakang tombol
                  foregroundColor: Colors.white, // Warna teks tombol
                  minimumSize: Size(screenWidth, 45),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.zero, // Membuat tombol menjadi kotak
                  ),
                ),
                child: Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
