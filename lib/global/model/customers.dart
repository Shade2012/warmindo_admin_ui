import 'dart:convert';

CustomerList customerListFromJson(String str) => CustomerList.fromJson(json.decode(str));

String customerListToJson(CustomerList data) => json.encode(data.toJson());

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
        success: json["success"],
        message: json["message"],
        data: List<CustomerData>.from(json["data"].map((x) => CustomerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CustomerData {
  int id;
  String name;
  String? profilePicture;
  String username;
  String email;
  String? emailVerifiedAt;
  String userVerified;
  String role;
  String phoneNumber;
  DateTime? phoneVerifiedAt;
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    id: json["id"],
    name: json["name"],
    profilePicture: json["profile_picture"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    userVerified: json["user_verified"],
    role: json["role"],
    phoneNumber: json["phone_number"],
    phoneVerifiedAt: json["phone_verified_at"] != null ? DateTime.parse(json["phone_verified_at"]) : null,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_picture": profilePicture,
    "username": username,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "user_verified": userVerified,
    "role": role,
    "phone_number": phoneNumber,
    "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
