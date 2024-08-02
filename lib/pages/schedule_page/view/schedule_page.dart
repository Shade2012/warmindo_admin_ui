import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Obx(() {
            final schedules = scheduleController.scheduleElement;
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
                      itemCount: scheduleController.scheduleElement.length,
                      itemBuilder: (context, index) {
                        var schedule = scheduleController.scheduleElement[index];
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheetSchedule();
                              },
                            );
                          },
                          child: Container(
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(schedule.start_time),
                                        SizedBox(width: 8),
                                        Text('-'),
                                        SizedBox(width: 8),
                                        Text(schedule.end_time),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),
              ],
            );
          }),
        ),
      ),
    );
  }
}
