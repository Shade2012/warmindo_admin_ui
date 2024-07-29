class CustomerList {
  bool success;
  String message;
  List<CustomerData> data;

  CustomerList({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    data: json['data'] != null
        ? List<CustomerData>.from(json['data'].map((x) => CustomerData.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CustomerData {
  int id;
  String name;
  String profilePicture;
  String username;
  String email;
  DateTime? emailVerifiedAt;
  String userVerified;
  String role;
  String phoneNumber;
  DateTime? phoneVerifiedAt;
  String googleId;
  DateTime createdAt;
  DateTime updatedAt;

  CustomerData({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    required this.userVerified,
    required this.role,
    required this.phoneNumber,
    this.phoneVerifiedAt,
    required this.googleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    profilePicture: json['profilePicture'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    emailVerifiedAt: json['emailVerifiedAt'] != null
        ? DateTime.parse(json['emailVerifiedAt'])
        : null,
    userVerified: json['userVerified'] ?? '',
    role: json['role'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    phoneVerifiedAt: json['phoneVerifiedAt'] != null
        ? DateTime.parse(json['phoneVerifiedAt'])
        : null,
    googleId: json['googleId'] ?? '',
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'profilePicture': profilePicture,
    'username': username,
    'email': email,
    'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
    'userVerified': userVerified,
    'role': role,
    'phoneNumber': phoneNumber,
    'phoneVerifiedAt': phoneVerifiedAt?.toIso8601String(),
    'googleId': googleId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
