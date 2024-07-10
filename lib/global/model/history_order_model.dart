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
  final int id;
  final bool paid;
  String catatan;
  String alasan_batal;
  String status;
  final String customerName;
  final String? reason;
  final String? paymentMethod;
  final String? orderMethod;
  final List<Menu> menus;

  Order({
    required this.id,
    required this.status,
    required this.orderMethod,
    required this.paid,
    required this.catatan,
    required this.alasan_batal,
    required this.menus,
    required this.customerName,
    this.reason,
    this.paymentMethod,
  });
}

List<Order> orderList = [
  // Order(
  //   id: 1,
  //   status: "Batal",
  //   orderMethod: "Takeaway",
  //   paymentMethod: "OVO",
  //   paid: true,
  //   catatan: 'Serondengnya dikit aja',
  //   alasan_batal: 'Sudah dibelikan makan oleh orang tua',
  //   customerName: 'Damar Fikri Haikal',
  //   menus: [
  //     Menu(
  //       name: "Mendoan",
  //       price: 1000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717137513.jpg',
  //     ),
  //     Menu(
  //       name: "Es Teh",
  //       price: 3000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146377.jpg',
  //     ),
  //     Menu(
  //       name: "Ayam Serondeng",
  //       price: 10000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg',
  //     ),
  //   ],
  // ),
  // Order(
  //   id: 2,
  //   status: "Selesai",
  //   orderMethod: "Takeaway",
  //   paymentMethod: "DANA",
  //   paid: true,
  //   catatan: '-',
  //   alasan_batal: '',
  //   customerName: 'Damar Fikri Haikal',
  //   menus: [
  //     Menu(
  //       name: "Ayam Serondeng",
  //       price: 10000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg',
  //     ),
  //   ],
  // ),
  // Order(
  //   id: 3,
  //   status: "Menunggu Batal",
  //   orderMethod: "Takeaway",
  //   paymentMethod: "DANA",
  //   paid: true,
  //   catatan: '-',
  //   alasan_batal: 'Sudah dibelikan makan oleh orang tua',
  //   customerName: 'Damar Fikri Haikal',
  //   menus: [
  //     Menu(
  //       name: "Ayam Serondeng",
  //       price: 10000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg',
  //     ),
  //   ],
  // ),
  // Order(
  //   id: 4,
  //   status: "Sedang Diproses",
  //   orderMethod: "Takeaway",
  //   paymentMethod: "DANA",
  //   paid: true,
  //   catatan: 'Serondengnya banyakin',
  //   alasan_batal: '',
  //   customerName: 'Damar Fikri Haikal',
  //   menus: [
  //     Menu(
  //       name: "Ayam Serondeng",
  //       price: 10000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg',
  //     ),
  //   ],
  // ),
  // Order(
  //   id: 5,
  //   status: "Pesanan Siap",
  //   orderMethod: "Takeaway",
  //   paymentMethod: "DANA",
  //   paid: true,
  //   catatan: '-',
  //   alasan_batal: '',
  //   customerName: 'Damar Fikri Haikal',
  //   menus: [
  //     Menu(
  //       name: "Ayam Serondeng",
  //       price: 10000,
  //       imagePath: 'https://warmindo.pradiptaahmad.tech/menu/1717146658.jpg',
  //     ),
  //   ],
  // ),
];
