import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:warmindo_admin_ui/pages/widget/circle_icon.dart';

class DetailVoucherPage extends StatelessWidget {
  const DetailVoucherPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: Text('Detail Voucher'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nikmati Kelezatan Tanpa Batas dengan Diskon 15% Ayo, Segera Pesan dan Rasakan Sensasi Minum yang Luar Biasa!',
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    CircleIcon(iconData: FontAwesomeIcons.ticket),
                    SizedBox(width: screenWidth / 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kode Voucher:'),
                        Text('NEWUSER5K'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 70),
                Row(
                  children: [
                    CircleIcon(iconData: FontAwesomeIcons.calendar),
                    SizedBox(width: screenWidth / 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Exp 25 Mar 2024 || '),
                        Text('31 Desember 2021'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 70),
                Container(
                  child: Text(
                    '🎉 Selamat datang di keluarga kami! 🎉\n\n'
                    'Dapatkan pengalaman berbelanja yang lebih menyenangkan dengan voucher eksklusif untuk Anda, pengguna baru kami! Gunakan kode voucher "NEWUSER5K" saat checkout dan nikmati potongan harga sebesar Rp 5000 untuk pembelian pertama Anda.\n\n'
                    'Syarat & Ketentuan:\n'
                    '- Hanya berlaku untuk pengguna baru yang baru pertama kali mendaftar dan melakukan pembelian di platform kami.\n'
                    '- Minimal pembelanjaan sebesar Rp 20.000 untuk bisa menggunakan voucher ini.\n'
                    '- Kode voucher hanya berlaku satu kali penggunaan per akun.\n'
                    '- Berlaku untuk semua produk kecuali yang telah dikecualikan.\n\n'
                    'Jangan lewatkan kesempatan spesial ini! Mulai jelajahi produk kami sekarang juga dan nikmati pengalaman berbelanja yang lebih hemat dan menyenangkan. Terima kasih atas kunjungan Anda dan selamat berbelanja!',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
