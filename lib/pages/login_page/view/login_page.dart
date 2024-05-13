import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_admin_ui/pages/widget/inputfield.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController ctrUsername = TextEditingController();
  final TextEditingController ctrPassword = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  String? isPassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Minimum password length is 8 characters';
    }
    return null;
  }

  String? isUsername(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  Widget Password(
    IconData icon,
    String label,
    String hint,
    TextEditingController controller2,
    String? Function(String)? validator,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: TextField(
        controller: controller2,
        obscureText: controller.obscureText.value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.obscureText.value = !controller.obscureText.value;
            },
            icon: Icon(controller.obscureText.value
                ? Icons.visibility
                : Icons.visibility_off),
          ),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          labelStyle: boldTextStyle,
          hintStyle: TextStyle(
            color: primaryTextColor,
            fontSize: 12,
          ),
          errorText: validator != null ? validator(controller2.text) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Center(
                      child: Text("Hello", style: helloLoginTextStyle),
                    ),
                  ),
                  Center(
                    child: Text("Selamat datang, kamu",
                        style: welcomeLoginTextStyle),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  myText(
                    Icons.person_2_outlined,
                    TextInputType.text,
                    "Username",
                    "Isi Username mu",
                    ctrUsername,
                    isUsername,
                  ),
                  Password(
                    Icons.lock_outline,
                    "Password",
                    "Isi Password mu",
                    ctrPassword,
                    isPassword,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isPassword(ctrPassword.text) == null &&
                          isUsername(ctrUsername.text) == null) {
                        // All fields are valid, perform login logic
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (isUsername(ctrUsername.text) == null)
                            ? ColorResources.buttonloginColor
                            : Colors.grey,
                      ),
                      width: screenWidth,
                      height: screenHeight * 0.0625,
                      child: Center(
                          child: Text("Login", style: whiteboldTextStyle)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.360, // Sesuaikan tinggi gambar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.muralLogin),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
