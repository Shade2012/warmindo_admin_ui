import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/input_notification_page/controller/input_notification_controller.dart';

class DevicePreview extends StatelessWidget {
  final InputNotificationController controller;

  DevicePreview({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 70, // Adjusted height to match the example
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900], // Background color similar to the example
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0), // Adjusted padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.title.value.isEmpty
                        ? 'Judul Notifikasi'
                        : controller.title.value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    controller.description.value.isEmpty
                        ? 'Deksripsi Notifikasi'
                        : controller.description.value,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
