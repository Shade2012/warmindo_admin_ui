import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/routes/AppPages.dart';
import 'package:warmindo_admin_ui/utils/themes/color_themes.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class BottomSheetShop extends StatefulWidget {
  const BottomSheetShop({Key? key}) : super(key: key);

  @override
  _BottomSheetShopState createState() => _BottomSheetShopState();
}

class _BottomSheetShopState extends State<BottomSheetShop> {
  String _selectedStatus = 'Beroperasi Normal';
  String? _selectedChip;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.58,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Text(
                'Status Restoran',
                style: titleBtsShopTextStyle,
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Cek status saat ini dan ubah statusnya dari sini.',
            style: titleLightBtsShopTextStyle,
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beroperasi Normal',
                        style: contentBoldBtsShopTextStyle,
                      ),
                      Text(
                        'Jam Operasional 24 Jam',
                        style: contentSmallBtsShopTextStyle,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Radio<String>(
                      value: 'Beroperasi Normal',
                      groupValue: _selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tutup Sementara',
                        style: contentBoldBtsShopTextStyle,
                      ),
                      Text(
                        'Ditutup sesuai dengan durasi yang ditentukan',
                        style: contentSmallBtsShopTextStyle,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Radio<String>(
                      value: 'Tutup Sementara',
                      groupValue: _selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStatus = value!;
                          _selectedChip = null; 
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Wrap(
                spacing: 8.0,
                children: [
                  ChoiceChip(
                    label: Text('30 menit'),
                    selected: _selectedChip == '30 menit',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedChip = selected ? '30 menit' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('60 menit'),
                    selected: _selectedChip == '60 menit',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedChip = selected ? '60 menit' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('90 menit'),
                    selected: _selectedChip == '90 menit',
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedChip = selected ? '90 menit' : null;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tutup',
                        style: contentBoldBtsShopTextStyle,
                      ),
                      Text(
                        'Tanpa durasi. Resto ditutup sampai dibuka kembali.',
                        style: contentSmallBtsShopTextStyle,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Radio<String>(
                      value: 'Tutup',
                      groupValue: _selectedStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedStatus = value!;
                          _selectedChip = null; // Reset selected chip
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Khusus',
                        style: contentBoldBtsShopTextStyle,
                      ),
                      Text(
                        'Buat jadwal khusus untuk restoran Anda',
                        style: contentSmallBtsShopTextStyle,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.SCHEDULE_PAGE);
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ubah Status'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth, 50),
                backgroundColor: ColorResources.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
