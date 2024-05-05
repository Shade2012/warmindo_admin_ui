import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';

class Order {
  final String id;
  final List<Menu> menus;
  final String status;
  final String nameCustomer;
  final String? reason;

  Order({required this.id, required this.menus, required this.status, required this.nameCustomer, this.reason});
}

class Menu {
  final String name;
  final double price;
  final String imagePath;
  

  Menu({required this.name, required this.price, required this.imagePath,});
}

// Objek Order pertama
Order order001 = Order(
  nameCustomer: 'Baratha Wijaya',
  status: 'Done',
  id: 'ID 001',
  menus: [
    Menu(
      name: 'Nasi Goreng',
      price: 15000, 
      imagePath: Images.splashLogo,
    ),
    Menu(
      name: 'Mie Goreng',
      price: 12000, 
      imagePath: Images.splashLogo,
    ),
  ],
);

Order order002 = Order(
  nameCustomer: 'Damar Fikri',
  id: 'ID 002',
  status: 'Cancel',
  menus: [
    Menu(
      name: 'Ayam Bakar',
      price: 20000, 
      imagePath: Images.splashLogo,
    ),
    Menu(
      name: 'Tahu Goreng',
      price: 5000, // Ubah string menjadi angka
      imagePath: Images.splashLogo,
    ),
  ],
);

Order order003 = Order(
  nameCustomer: 'Damar Fikri',
  id: 'ID 003',
  status: 'Permintaan Pembatalan',
  reason: 'Salah Menggunakan Metode Pembayaran',
  menus: [
    Menu(
      name: 'Es Teh',
      price: 3000, 
      imagePath: Images.esTeh,
    ),
  ],
);
