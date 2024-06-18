import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/global/themes/color_themes.dart';
import 'package:warmindo_admin_ui/global/themes/image_themes.dart';

class GeneralInformation extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    _fullNameController.text = "admin";
    _emailController.text = "admin@gmail.com";
    _phoneNumberController.text = "0821-2480-5253";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Informasi Umum"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      Images.userImage,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.16),
                TextFormField(
                  readOnly: true,
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  readOnly: true,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address is required";
                    }
                    if (!value.contains("@")) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  readOnly: true,
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(screenWidth, screenHeight * 0.06),
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // Update profile information
                    //   print("Full Name: ${_fullNameController.text}");
                    //   print("Email Address: ${_emailController.text}");
                    //   print("Phone Number: ${_phoneNumberController.text}");
                    //   // print("Username: ${_usernameController.text}");

                    //   // Show a success message or perform other actions
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text("Profile updated successfully!"),
                    //     ),
                    //   );
                    // }
                    Get.toNamed(Routes.EDIT_PROFILE_PAGE);
                  },
                  child: Text("Edit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
