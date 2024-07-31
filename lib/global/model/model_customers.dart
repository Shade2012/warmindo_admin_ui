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
  String? profilePicture;
  String username;
  String email;
  DateTime? emailVerifiedAt;
  String userVerified;
  String role;
  String phoneNumber;
  DateTime? phoneVerifiedAt;
  String? googleId;
  DateTime createdAt;
  DateTime updatedAt;

  CustomerData({
    required this.id,
    required this.name,
    this.profilePicture,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    required this.userVerified,
    required this.role,
    required this.phoneNumber,
    this.phoneVerifiedAt,
    this.googleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    profilePicture: json['profile_picture'],
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    emailVerifiedAt: json['email_verified_at'] != null
        ? DateTime.parse(json['email_verified_at'])
        : null,
    userVerified: json['user_verified'] ?? '',
    role: json['role'] ?? '',
    phoneNumber: json['phone_number'] ?? '',
    phoneVerifiedAt: json['phone_verified_at'] != null
        ? DateTime.parse(json['phone_verified_at'])
        : null,
    googleId: json['google_id'],
    createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'profile_picture': profilePicture,
    'username': username,
    'email': email,
    'email_verified_at': emailVerifiedAt?.toIso8601String(),
    'user_verified': userVerified,
    'role': role,
    'phone_number': phoneNumber,
    'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
    'google_id': googleId,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  CustomerData copyWith({
    int? id,
    String? name,
    String? profilePicture,
    String? username,
    String? email,
    DateTime? emailVerifiedAt,
    String? userVerified,
    String? role,
    String? phoneNumber,
    DateTime? phoneVerifiedAt,
    String? googleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerData(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      userVerified: userVerified ?? this.userVerified,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
      googleId: googleId ?? this.googleId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
