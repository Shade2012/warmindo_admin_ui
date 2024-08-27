import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';
import 'package:warmindo_admin_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_admin_ui/pages/otp_page/controller/otp_controller.dart'; // Import OtpController

class OtpPage extends StatelessWidget {
  final TextEditingController _codeController1 = TextEditingController();
  final TextEditingController _codeController2 = TextEditingController();
  final TextEditingController _codeController3 = TextEditingController();
  final TextEditingController _codeController4 = TextEditingController();
  final TextEditingController _codeController5 = TextEditingController();
  final TextEditingController _codeController6 = TextEditingController();
  final OtpController otpController = Get.put(OtpController()); // Initialize OtpController
  final LoginController loginController = Get.find<LoginController>();

  OtpPage({Key? key}) : super(key: key);

  void _submitCode() async {
    final code = _codeController1.text +
        _codeController2.text +
        _codeController3.text +
        _codeController4.text +
        _codeController5.text +
        _codeController6.text;

    if (code.length == 6) {
      // Proceed with the code submission logic
      print('Submitted code: $code');

      // Call the function to verify the code
      try {
        await otpController.verifyOtp(code, loginController.ctrEmail.text);
        // Navigate to the next page or show success message
        // Example of navigation after success
        // Get.offAllNamed(Routes.NEXT_PAGE);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Gagal memverifikasi kode. Silakan coba lagi.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Masukkan kode verifikasi yang benar',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _resendCode() {
    // Logic to resend the code
    print('Resend code tapped!');
    Get.snackbar(
      'Berhasil',
      'Kode verifikasi telah dikirim ulang',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = loginController.ctrEmail.text;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kode Verifikasi', style: appBarTextStyle),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Add navigation logic here
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan kode verifikasi',
              style: helloLoginTextStyle,
            ),
            SizedBox(height: 8),
            Text(
              'Masukkan kode verifikasi yang kami kirimkan ke email anda ${email}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCodeField(_codeController1),
                _buildCodeField(_codeController2),
                _buildCodeField(_codeController3),
                _buildCodeField(_codeController4),
                _buildCodeField(_codeController5),
                _buildCodeField(_codeController6),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCode,
              child: Text('Kirim', style: blackvoucherTextStyle),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.8, 50),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _resendCode,
              child: Text(
                'Kirim ulang kode',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeField(TextEditingController controller) {
    return Container(
      width: 40,
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(Get.context!).nextFocus();
          }
        },
      ),
    );
  }
}
