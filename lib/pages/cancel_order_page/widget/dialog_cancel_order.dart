import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class DialogCancelOrder extends StatelessWidget {
  final String title;
  final String content;
  final String content2;
  final String cancelText;
  final String confirmText;
  final Function onCancelPressed;
  final Function onConfirmPressed;
  final Color cancelButtonColor;
  final Color confirmButtonColor;
  final Color cancelButtonTextColor;
  final Color confirmButtonTextColor;
  final Widget? dialogImage;

  DialogCancelOrder({
    required this.title,
    required this.content,
    required this.content2,
    required this.cancelText,
    required this.confirmText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
    this.cancelButtonColor = Colors.red,
    this.confirmButtonColor = Colors.green,
    this.cancelButtonTextColor = Colors.white,
    this.confirmButtonTextColor = Colors.white,
    this.dialogImage,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,  // Remove default padding
      title: Column(
        children: [
          Stack(
            children: [
              if (dialogImage != null)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: dialogImage!,
                  ),
                ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          Text(
            title,
            style: titleDialogButtonTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(height * 0.01),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(Icons.info, color: Colors.black,), 
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      content,
                      style: contentDialogButtonTextStyle,
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      content2,
                      style: contentDialogButtonTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.005),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onCancelPressed as void Function()?,
                style: TextButton.styleFrom(
                  minimumSize: Size(width * 0.3, height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: cancelButtonColor,
                  foregroundColor: cancelButtonTextColor,
                  shadowColor: Colors.black,
                  elevation: 0,
                ),
                child: Text(
                  cancelText,
                  style: dialogendButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: onConfirmPressed as void Function()?,
                style: TextButton.styleFrom(
                  minimumSize: Size(width * 0.3, height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                    side: BorderSide(color: Colors.white),
                  ),
                  backgroundColor: confirmButtonColor,
                  foregroundColor: confirmButtonTextColor,
                  shadowColor: Colors.black,
                  elevation: 0,
                ),
                child: Text(
                  confirmText,
                  style: dialogButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
