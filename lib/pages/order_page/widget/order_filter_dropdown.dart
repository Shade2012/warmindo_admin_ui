import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/global/model/modelorder.dart';
import 'package:warmindo_admin_ui/global/themes/textstyle_themes.dart';

class OrderFilterDropdown extends StatelessWidget {
  final List<Order> orders;
  final double screenHeight;
  final double screenWidth;
  final ValueNotifier<String> selectedStatus;
  final ValueChanged<String?>? onChanged;

  const OrderFilterDropdown({
    Key? key,
    required this.orders,
    required this.screenHeight,
    required this.screenWidth,
    required this.selectedStatus,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedStatus.value,
          onChanged: onChanged,
          items: <String>[
            'Semua',
            'Dalam Proses',
            'Pesanan Siap',
            'Selesai',
            'Menunggu Batal',
            'Batal'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                height: screenHeight * 0.056,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Semua Pesanan',
            hintStyle: filterTextStyle,
            fillColor: Colors.red,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
          ),
          dropdownColor: Colors.black, // Warna latar belakang dropdown
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white, // Warna ikon putih
          ),
        ),
      ],
    );
  }
}
