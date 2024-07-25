import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/view/bottomsheet_schedule_page.dart';
import 'package:warmindo_admin_ui/pages/schedule_page/controller/schedule_controller.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Jadwal Restoran'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.03,
          ),
          child: Obx(() {
            final schedules = scheduleController.schedules;
            final isScheduleEmpty = schedules.isEmpty;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isScheduleEmpty)
                  Column(
                    children: [
                      Image.asset(Images.datePicker),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Memperkenalkan Jadwal Khusus',
                        textAlign: TextAlign.center,
                        style: scheduleTitleTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Tambahkan jam buka khusus untuk libur nasional atau libur lainnya',
                        textAlign: TextAlign.center,
                        style: scheduleContentTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                if (!isScheduleEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        var schedule = schedules[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schedule.days,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(schedule.hours),
                                  SizedBox(height: 4),
                                  Text('Temporary Closure: ${schedule.temporaryClosureDuration}'),
                                  SizedBox(height: 4),
                                  Text('Status: ${schedule.isOpen ? 'Open' : 'Closed'}'),
                                ],
                              ),
                              Switch(
                                value: schedule.isOpen,
                                onChanged: (newValue) {
                                  // Update the schedule status
                                  scheduleController.updateStatusSchedule(
                                    isOpen: newValue ? '1' : '0',
                                    temporaryClosureDuration: schedule.temporaryClosureDuration,
                                  );
                                  print('isOpen value changed to: $newValue');
                                },
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      builder: (BuildContext context) {
                        return BottomSheetSchedule();
                      },
                    ).whenComplete(() {
                      // Optionally refresh schedule list after adding new schedule
                      scheduleController.fetchScheduleList();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: ColorResources.primaryColorLight,
                    minimumSize: Size(screenWidth * 0.6, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text('Tambah Jadwal Khusus'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
