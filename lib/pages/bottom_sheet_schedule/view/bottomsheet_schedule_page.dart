import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/controller/bottomsheet_schedule_controller.dart';
import 'dart:developer';

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
        height: screenHeight * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: screenHeight * 0.11),
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
                      elevation: 0,
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
