import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/home_page/model/modelorder.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/pages/widget/orderBox.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedStatus;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Order',
        showBackButton: true,
        onBackButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedStatus,
              onChanged: (String? newValue) {
                // For stateless widget, you might want to use a state management solution
                // like Provider, Bloc or getX to manage state changes.
                // Here, I'm just updating the local variable directly.
                selectedStatus = newValue;
              },
              items: <String>[
                'All',
                'Done',
                'In Progress',
                'Cancel',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: categoryTextStyle),
                );
              }).toList(),
              decoration: InputDecoration(
                fillColor: Colors.red,
                filled: false,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // You can customize the implementation to use a ListView.builder
            // based on the actual order data.
            OrderBox(
              order: order001,
              status: 'Done',
              nameCustomer: 'Baratha Wijaya',
            ),
            SizedBox(height: 10),
            OrderBox(
              order: order002,
              status: 'In Progress',
              nameCustomer: 'Damar Fikri',
            ),
          ],
        ),
      ),
    );
  }
}
