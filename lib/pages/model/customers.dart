import 'package:warmindo_admin_ui/utils/themes/image_themes.dart';

class Customers {
  final String id; 
  final String name;
  final String image;
  final String email;
  final String phone;
  final String verification;

  Customers({
    required this.id, 
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    required this.verification,
  });
}

final List<Customers> customerList = [
  Customers(
    id: '001', 
    name: 'Damar Fikri Haikal',
    verification: 'Verified',
    image: Images.userImage,
    email: 'damarfikri@gmail.com',
    phone: '+6282124805253',
  ),
  Customers(
    id: '002', 
    name: 'Baratha Wijaya',
    verification: 'Unverified',
    image: Images.userImage,
    email: 'barathawijaya@gmail.com',
    phone: '+628224398758',
  ),
];
