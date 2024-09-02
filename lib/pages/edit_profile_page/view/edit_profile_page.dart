import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_admin_ui/global/widget/up_image_bottomsheet.dart';
import 'package:warmindo_admin_ui/pages/edit_profile_page/controller/edit_profile_controller.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class EditProfilPage extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void getImage(ImageSource source) {
      controller.getImage(source);
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorResources.primaryColor,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: screenWidth * 0.05,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Spacer(),
                        Center(
                          child: Text(
                            "Ubah Profil",
                            style: subheaderRegularStyle,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.13),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => UploadImage(
                          onImageCapture: getImage,
                        ),
                      ),
                      child: Obx(() {
                        if (controller.selectedImage.value != null) {
                          return CircleAvatar(
                            radius: screenWidth * 0.2,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage:
                                FileImage(controller.selectedImage.value!),
                          );
                        } else {
                          return CircleAvatar(
                            radius: screenWidth * 0.2,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: Image.network(
                              controller.image.value.isEmpty
                                  ? Images.userImage
                                  : 'https://warmindo.pradiptaahmad.tech/image/' +
                                      controller.image.value,
                            ).image,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: screenWidth * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: screenWidth * 0.08,
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Text("Nama", style: regularInputTextStyle),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.03),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              controller.fullNameController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full name is required";
                          }
                          return null;
                        },
                        style: regularInputTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text("Email", style: regularInputTextStyle),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.03),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              controller.emailController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email address is required";
                          }
                          if (!value.contains("@")) {
                            return "Invalid email address";
                          }
                          return null;
                        },
                        style: regularInputTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text("Nomor Hp", style: regularInputTextStyle),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.03),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              controller.phoneNumberController.clear();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nomor Hp di perlukan";
                          }
                          if (value.length < 11) {
                            return "Nomor Hp tidak valid";
                          }
                          return null;
                        },
                        style: regularInputTextStyle,
                      ),
                      SizedBox(height: screenHeight * 0.22),
                      Center(
                        child: Obx(() {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: Size(screenWidth * 0.9, screenHeight * 0.06),
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print('berhasil tahap 1');
                                if (controller.selectedImage.value?.path == '') {
                                  await controller.editProfile(
                                    name: controller.fullNameController.text,
                                    username: controller.usernameController.text,
                                    email: controller.emailController.text,
                                    numberPhone: controller.phoneNumberController.text,
                                  );
                                  print('image ada');
                                } else {
                                  await controller.editProfile(
                                    name: controller.fullNameController.text,
                                    username: controller.usernameController.text,
                                    email: controller.emailController.text,
                                    image: controller.selectedImage.value,
                                    numberPhone: controller.phoneNumberController.text,
                                  );
                                  print('image saat ini : ${controller.selectedImage.value}');
                                  controller.selectedImage.value = File('');
                                  print('image setelah proses kosong : ${controller.selectedImage.value}');
                                  print('image kosong');
                                }
                              }
                            },
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Ubah Data"),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
