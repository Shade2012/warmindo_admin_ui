import 'package:flutter/material.dart';

enum DropdownType { Category, Stock, Status, VerificationStatus,SecondCategory, StatusMenu }

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? hint;
  final DropdownType dropdownType;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint,
    required this.dropdownType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hintText;
    switch (dropdownType) {
      case DropdownType.Category:
        hintText = hint ?? 'Pilih Category';
        break;
      case DropdownType.Stock:
        hintText = hint ?? 'Pilih Stock';
        break;
      case DropdownType.Status:
        hintText = hint ?? 'Pilih Status';
        break;
      case DropdownType.SecondCategory:
        hintText = hint ?? 'Pilih Kategory Kedua';
        break;
      case DropdownType.VerificationStatus:
        hintText = hint ?? 'Pilih Status Verifikasi';
        break;
      case DropdownType.StatusMenu:
        hintText = hint ?? 'Pilih Status Menu';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        icon: Icon(Icons.arrow_drop_down_sharp),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontSize: 16),
        underline: Container(),
        onChanged: onChanged,
        items: [
          DropdownMenuItem<String>(
            value: null,
            child: Text(hintText, style: TextStyle(color: Colors.grey)),
          ),
          ...items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }),
        ],
      ),
    );
  }
}
