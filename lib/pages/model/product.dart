import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';

class Product {
  final String name;
  final String category;
  final String image;
  final int stock;
  final double price; // Menambahkan harga ke dalam model Product

  Product({
    required this.name,
    required this.category,
    required this.image,
    required this.stock,
    required this.price,
  });
}

final List<Product> productList = [
  Product(
    name: 'Mie Ayam Bawang',
    category: 'Makanan',
    image: Images.mieAyam,
    stock: 10,
    price: 15000, // Menambahkan harga untuk Mie Ayam Bawang
  ),
  Product(
    name: 'Mie Ayam Bakso',
    category: 'Makanan',
    image: Images.mieBakso,
    stock: 5,
    price: 17000, // Menambahkan harga untuk Mie Ayam Bakso
  ),
  Product(
    name: 'Es Teh',
    category: 'Minuman',
    image: Images.esTeh,
    stock: 20,
    price: 5000, // Menambahkan harga untuk Es Teh
  ),
  Product(
    name: 'Es Jeruk',
    category: 'Minuman',
    image: Images.esTeh,
    stock: 15,
    price: 6000, // Menambahkan harga untuk Es Jeruk
  ),
  Product(
    name: 'Telur Dadar',
    category: 'Topping',
    image: Images.telurDadar,
    stock: 8,
    price: 2000, // Menambahkan harga untuk Telur Dadar
  ),
];
