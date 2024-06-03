import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/themes/textstyle_themes.dart';
import '../add_product_page/controller/add_product_controller.dart';
import 'package:get/get.dart';

import '../edit_product_page/controller/edit_product_controller.dart';
typedef ImageCaptureCallback = void Function(ImageSource source);
class UploadImage extends StatelessWidget {
  final ImageCaptureCallback? onImageCapture;


  UploadImage({this.onImageCapture,});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  onImageCapture!(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 40),
                    SizedBox(height: 10),
                    Text('Camera', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.3),
              GestureDetector(
                onTap:  () {
                  onImageCapture!(ImageSource.gallery);
                }
                    ,
                child: Column(
                  children: [
                    Icon(Icons.photo, size: 40),
                    SizedBox(height: 10),
                    Text('Gallery', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

