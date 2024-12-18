import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/schedule_page/controller/schedule_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class BottomSheetShop extends StatelessWidget {
  final int scheduleId; // Assuming this is passed to the widget

  const BottomSheetShop({Key? key, required this.scheduleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScheduleController statusController = Get.put(ScheduleController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.58,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              ),
              Text(
                'Status Restoran',
                style: titleBtsShopTextStyle,
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Cek status saat ini dan ubah statusnya dari sini.',
            style: titleLightBtsShopTextStyle,
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buka',
                            style: contentBoldBtsShopTextStyle,
                          ),
                          Text(
                            'Toko Buka',
                            style: contentSmallBtsShopTextStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Radio<String>(
                          value: 'Beroperasi Normal',
                          groupValue: statusController.selectedStatus.value,
                          onChanged: (String? value) {
                            statusController.setStatus(value!);
                            statusController.resetChip();
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tutup Sementara',
                            style: contentBoldBtsShopTextStyle,
                          ),
                          Text(
                            'Ditutup sesuai dengan durasi yang ditentukan',
                            style: contentSmallBtsShopTextStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Radio<String>(
                          value: 'Tutup Sementara',
                          groupValue: statusController.selectedStatus.value,
                          onChanged: (String? value) {
                            statusController.setStatus(value!);
                            statusController.resetChip();
                          },
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: screenHeight * 0.01),
              Obx(() => Wrap(
                    spacing: 8.0,
                    children: [
                      ChoiceChip(
                        label: Text('30 menit'),
                        selected: statusController.selectedChip.value == '30 menit',
                        onSelected: (bool selected) {
                          statusController.setChip(selected ? '30 menit' : '');
                        },
                      ),
                      ChoiceChip(
                        label: Text('60 menit'),
                        selected: statusController.selectedChip.value == '60 menit',
                        onSelected: (bool selected) {
                          statusController.setChip(selected ? '60 menit' : '');
                        },
                      ),
                      ChoiceChip(
                        label: Text('90 menit'),
                        selected: statusController.selectedChip.value == '90 menit',
                        onSelected: (bool selected) {
                          statusController.setChip(selected ? '90 menit' : '');
                        },
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tutup',
                            style: contentBoldBtsShopTextStyle,
                          ),
                          Text(
                            'Toko Tutup',
                            style: contentSmallBtsShopTextStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Radio<String>(
                          value: 'Tutup',
                          groupValue: statusController.selectedStatus.value,
                          onChanged: (String? value) {
                            statusController.setStatus(value!);
                            statusController.resetChip();
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Khusus',
                            style: contentBoldBtsShopTextStyle,
                          ),
                          Text(
                            'Atur Jadwal khusus restoran anda',
                            style: contentSmallBtsShopTextStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Radio<String>(
                          value: 'Jadwal Khusus',
                          groupValue: statusController.selectedStatus.value,
                          onChanged: (String? value) {
                            statusController.setStatus(value!);
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (statusController.selectedStatus.value == 'Jadwal Khusus') {
                  Get.back();
                  Get.toNamed(Routes.SCHEDULE_PAGE);
                } else {
                  if(statusController.selectedStatus.value == 'Beroperasi Normal'){
                    // await statusController.updateStatusSchedule(
                    //   start_time: '00:00:00',
                    //   temporaryClosureDuration: '0',
                    //   end_time: '23:59:59',
                    // );
                    await statusController.openStore();
                  }else if(statusController.selectedStatus.value == 'Tutup Sementara'){
                    if(statusController.selectedChip.value == '30 menit'){
                      await statusController.updateStatusSchedule(
                        temporaryClosureDuration: '30'
                      );
                    }
                    else if(statusController.selectedChip.value == '60 menit'){
                      await statusController.updateStatusSchedule(
                          temporaryClosureDuration: '60'
                      );
                    }
                    else if(statusController.selectedChip.value == '90 menit'){
                      await statusController.updateStatusSchedule(
                          temporaryClosureDuration: '90'
                      );
                    }
                  }else if(statusController.selectedStatus.value == 'Tutup'){
                    // await statusController.updateStatusSchedule(
                    //     end_time: '00:00:00'
                    // );
                    await statusController.closeStore();
                  }
                  print('Selected status: ${statusController.selectedStatus.value}');
                  print('Selected chip: ${statusController.selectedChip.value}');
                  print('Status saat ini ${statusController.jadwalElement[0].is_open}');
                  print('tutup sementara saat ini ${statusController.jadwalElement[0].temporary_closure_duration}');
                  print('jam terakhir saat ini ${statusController.jadwalElement[0].end_time}');
                }
              },
              child: Text('Ubah Status'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth, 50),
                backgroundColor: ColorResources.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

