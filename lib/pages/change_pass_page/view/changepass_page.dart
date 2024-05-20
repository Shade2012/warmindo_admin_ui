import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';

class ChangePassPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

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
        centerTitle: true,
        title: Text("Ubah Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Untuk mengubah password, silakan isi formulir di bawah ini:",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: screenHeight * 0.02),
                typePass(
                  TextInputType.text,
                  "Password Lama",
                  "Masukkan password lama",
                  _currentPasswordController,
                  (value) {
                    if (value.isEmpty) {
                      return "Password Lama diperlukan";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.002),
                typePass(
                  TextInputType.text,
                  "Password Baru",
                  "Masukkan password baru",
                  _newPasswordController,
                  (value) {
                    if (value.isEmpty) {
                      return "Password Baru diperlukan";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.002),
                typePass(
                  TextInputType.text,
                  "Konfirmasi Password Baru",
                  "Konfirmasi password baru",
                  _confirmNewPasswordController,
                  (value) {
                    if (value.isEmpty) {
                      return "Konfirmasi Password Baru diperlukan";
                    }
                    if (_newPasswordController.text != value) {
                      return "Password Baru dan Konfirmasi Password Baru tidak sama";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size(screenWidth, screenHeight * 0.06),
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Change password
                      print(
                          "Password Lama: ${_currentPasswordController.text}");
                      print("Password Baru: ${_newPasswordController.text}");
                      Get.back();
                      // Show a success message or perform other actions
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password berhasil diubah!"),
                        ),
                      );
                    }
                  },
                  child: Text("Ubah Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget typePass(
  TextInputType keyboardType,
  String label,
  String hint,
  TextEditingController controller,
  String? Function(String)? validator,
) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: hint,
        labelText: label,
        hintStyle: TextStyle(color: Colors.black),
        errorStyle: TextStyle(color: Colors.black), 
        errorText: validator != null ? validator(controller.text) : null,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}
