import 'package:flutter/material.dart';
import 'package:warmindo_admin_ui/pages/model/customers.dart';
import 'package:warmindo_admin_ui/pages/widget/customAppBar.dart';
import 'package:warmindo_admin_ui/utils/themes/textstyle_themes.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Verifikasi Pelanggan',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: customerList.map((customer) {
            return Container(
              margin: EdgeInsets.only(top: 10, bottom: 5), // Menambahkan jarak antara setiap container
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 410,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Pengguna',
                        style: headerverificationTextStyle,
                      ),
                      Text(
                        '#${customer.id}',
                        style: headerverificationTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Spacer antara judul dan konten utama
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: AssetImage(customer.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Spacer antara gambar dan teks
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, // Vertically center the text
                        children: [
                          Text(
                            customer.name, // Gunakan data nama dari customer
                            style: contentverificationTextStyle,
                          ),
                          SizedBox(height: 20),
                          Text(
                            customer.verification, // Gunakan data verifikasi dari customer
                            style: customer.verification == 'Verified' ? verificationTextStyle : unverificationTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
