import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/ChangePassword_page/controller/change_password_controller.dart';
import 'package:warmindo_admin_ui/pages/change_pass_page/widget/typePassword.dart';

class ForgotPass extends StatelessWidget {
  final ForgotPassController controller = Get.put(ForgotPassController());
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Center(child: Text("Lupa Kata Sandi", style: appBarTextStyle)),
                  SizedBox(height: screenHeight * 0.03),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Untuk mengubah password, silakan isi formulir di bawah ini:",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        typePass(
                          TextInputType.text,
                          "Password Baru",
                          _newPasswordController,
                          (value) {
                            if (value!.isEmpty) {
                              return "Password Baru diperlukan";
                            }
                            if (value.length < 8) {
                              return "Password Baru harus terdiri dari minimal 8 karakter";
                            }
                            return null;
                          },
                          false.obs,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        typePass(
                          TextInputType.text,
                          "Konfirmasi Password Baru",
                          _confirmNewPasswordController,
                          (value) {
                            if (value!.isEmpty) {
                              return "Konfirmasi Password Baru diperlukan";
                            }
                            if (_newPasswordController.text != value) {
                              return "Password Baru dan Konfirmasi Password Baru tidak sama";
                            }
                            return null;
                          },
                          false.obs,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            minimumSize: Size(screenWidth * 0.9, screenHeight * 0.06),
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.changePass(
                                password: _newPasswordController.text,
                                password_confirmation: _confirmNewPasswordController.text,
                              );
                            }
                          },
                          child: Text("Ubah Password"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
