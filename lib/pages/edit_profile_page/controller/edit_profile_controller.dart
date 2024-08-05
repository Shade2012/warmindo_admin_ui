import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_admin_ui/global/endpoint/warmindo_repository.dart';
import 'package:warmindo_admin_ui/pages/general_information_page/controller/general_info_controller.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';

class EditProfileController extends GetxController {
  final GeneralInformationController profileController = Get.put(GeneralInformationController());
  RxBool isLoading = true.obs;
  RxBool isConnected = true.obs;
  RxString image = "".obs;
  RxString name = "".obs;
  RxString username = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString token = "".obs;
  SharedPreferences? prefs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    initializeControllers();
  }

  void initializeControllers() {
    fullNameController.text = name.value;
    usernameController.text = username.value;
    emailController.text = email.value;
    phoneNumberController.text = phoneNumber.value;
  }

  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {
      username.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        checkSharedPreference();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      checkSharedPreference();
    }
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      username.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
      print("Token: ${token.value}");
      if (token.value.isNotEmpty) {
        fetchData();
      } else {
        print("Token is empty");
      }
    }
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AuthEndpoint().detailUser),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
          "Accept": "application/json",
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        final userData = responseData['user'];
        username.value = userData['username'] ?? '';
        name.value = userData['name'] ?? '';
        email.value = userData['email'] ?? '';
        phoneNumber.value = userData['phone_number'] ?? '';
        image.value = userData['profile_picture'] ?? '';

        // Update TextEditingControllers
        fullNameController.text = name.value;
        emailController.text = email.value;
        phoneNumberController.text = phoneNumber.value;
        usernameController.text = username.value;
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editProfile({
    String? name,
    String? username,
    String? email,
    File? image,
  }) async {
    final url = Uri.parse(AuthEndpoint().updateAdminData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      isLoading.value = true;

      // Create a multipart request
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name ?? ''
        ..fields['username'] = username ?? ''
        ..fields['email'] = email ?? '';

      if (image != null) {
        request.files.add(http.MultipartFile(
          'profile_picture',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'product_image.jpg' 'product_image.png' 'product_image.jpeg',
        ));
      }

      print('Request URL: $url');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files}');

      // Send the request
      var response = await http.Response.fromStream(await request.send());

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Handle the response
      if (response.statusCode == 201) {
        isLoading.value = false;
        profileController.checkSharedPreference();
        Get.toNamed(Routes.BOTTOM_NAVIGATION);
        Get.snackbar(
          'Success',
          'Berhasil Dirubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 400) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password Saat ini tidak sesuai',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 422) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password Tidak Sama',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
        print('error biasa : ${response.body}');
        Get.snackbar(
          'Error biasa',
          'Error: ${response.statusCode} ${response.body}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error Catch',
        'Error occurred: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('$e');
    } finally {
      isLoading.value = false;
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path); // Store image as File
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Tidak ada gambar yang dipilih',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }
}