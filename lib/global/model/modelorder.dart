import 'package:warmindo_admin_ui/global/themes/image_themes.dart';

// Definisi kelas Menu jika belum ada
class Menu {
  final String name;
  final double price;
  final String imagePath;

  Menu({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class Order {
  final String id;
  final List<Menu> menus;
  final String status;
  final String nameCustomer;
  final String dateOrder;
  final String? reason;
  final String? paymentMethod;
  final String? email;
  final String? phoneNumber;

  Order({
    required this.id,
    required this.menus,
    required this.status,
    required this.nameCustomer,
    required this.dateOrder,
    this.reason,
    this.paymentMethod,
    this.email,
    this.phoneNumber,
  });

  Order copyWith({
    String? id,
    List<Menu>? menus,
    String? status,
    String? nameCustomer,
    String? dateOrder,
    String? reason,
    String? paymentMethod,
    String? email,
    String? phoneNumber,
  }) {
    return Order(
      id: id ?? this.id,
      menus: menus ?? this.menus,
      status: status ?? this.status,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      dateOrder: dateOrder ?? this.dateOrder,
      reason: reason ?? this.reason,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

// Contoh penggunaan kelas Order
Order order001 = Order(
  nameCustomer: 'Baratha Wijaya',
  paymentMethod: 'Tunai',
  dateOrder: '2021-10-10',
  email: 'barathawijaya@gmail.com',
  phoneNumber: '081234567890',
  status: 'Selesai',
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
  paymentMethod: 'OVO',
  email: 'damarfikri@gmail.com',
  dateOrder: '2021-10-10',
  phoneNumber: '081234567890',
  id: 'ID 002',
  status: 'Batal',
  menus: [
    Menu(
      name: 'Ayam Bakar',
      price: 20000,
      imagePath: Images.splashLogo,
    ),
    Menu(
      name: 'Tahu Goreng',
      price: 5000,
      imagePath: Images.splashLogo,
    ),
  ],
);

Order order003 = Order(
  nameCustomer: 'Damar Fikri',
  dateOrder: '2021-10-10',
  paymentMethod: 'Tunai',
  email: 'damarfikri@gmail.com',
  phoneNumber: '081234567890',
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
