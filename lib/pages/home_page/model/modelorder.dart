import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';

class Order {
  final String id;
  final List<Menu> menus;

  Order({required this.id, required this.menus});
}

class Menu {
  final String name;
  final double price;
  final String imagePath;

  Menu({required this.name, required this.price, required this.imagePath});
}

// Objek Order pertama
Order order001 = Order(
  id: 'ID 001',
  menus: [
    Menu(
      name: 'Nasi Goreng',
      price: 15000, // Ubah string menjadi angka
      imagePath: Images.splashLogo,
    ),
    Menu(
      name: 'Mie Goreng',
      price: 12000, // Ubah string menjadi angka
      imagePath: Images.splashLogo,
    ),
  ],
);

Order order002 = Order(
  id: 'ID 002',
  menus: [
    Menu(
      name: 'Ayam Bakar',
      price: 20000, // Ubah string menjadi angka
      imagePath: Images.splashLogo,
    ),
    // Menu(
    //   name: 'Tahu Goreng',
    //   price: 5000, // Ubah string menjadi angka
    //   imagePath: Images.splashLogo,
    // ),
  ],
);
