import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/controller/bottomsheet_schedule_controller.dart';
import 'package:warmindo_admin_ui/pages/bottom_sheet_schedule/view/bottomsheet_schedule_page.dart';
import 'package:warmindo_admin_ui/pages/navigator_page/controller/navigator_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

enum Day {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

extension DayExtension on Day {
  String get name {
    switch (this) {
      case Day.Sunday:
        return 'Minggu';
      case Day.Monday:
        return 'Senin';
      case Day.Tuesday:
        return 'Selasa';
      case Day.Wednesday:
        return 'Rabu';
      case Day.Thursday:
        return 'Kamis';
      case Day.Friday:
        return 'Jumat';
      case Day.Saturday:
        return 'Sabtu';
      default:
        return '';
    }
  }
}

class SchedulePage extends StatelessWidget {
  final BottomSheetScheduleController _controller = Get.put(BottomSheetScheduleController());

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
            Get.find<NavigatorController>().goToSettingsPage();
            Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
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
            final schedules = _controller.schedules;
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
                                    '${schedule.days.map((day) => day.name).join(', ')}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  if (schedule.is24Hours)
                                    Text(
                                      '24 Jam',
                                    ),
                                  if (!schedule.is24Hours && schedule.isClosed)
                                    Text(
                                      'Tutup',
                                    ),
                                  if (!schedule.is24Hours && !schedule.isClosed && schedule.openingTime != null && schedule.closingTime != null)
                                    Text(
                                      '${(schedule.formattedOpeningTime())} - ${(schedule.formattedClosingTime())}',
                                    ),
                                ],
                              ),
                              Switch(
                                value: schedule.isActive,
                                onChanged: (newValue) {
                                  _controller.updateScheduleStatus(index, newValue);
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
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: ColorResources.primaryColorLight,
                    minimumSize: Size(screenWidth * 0.6, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    'Tambah Jadwal Khusus',
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
