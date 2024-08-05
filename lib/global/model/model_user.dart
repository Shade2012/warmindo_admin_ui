import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool success;
    String message;
    User user;
    Token token;

    UserModel({
        required this.success,
        required this.message,
        required this.user,
        required this.token,
    });

    UserModel copyWith({
        bool? success,
        String? message,
        User? user,
        Token? token,
    }) => 
        UserModel(
            success: success ?? this.success,
            message: message ?? this.message,
            user: user ?? this.user,
            token: token ?? this.token,
        );

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: Token.fromJson(json["token"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user.toJson(),
        "token": token.toJson(),
    };
}

class Token {
    int id;
    String tokenableType;
    String tokenableId;
    String name;
    List<String> abilities;
    DateTime lastUsedAt;
    dynamic expiresAt;
    DateTime createdAt;
    DateTime updatedAt;
    User tokenable;

    Token({
        required this.id,
        required this.tokenableType,
        required this.tokenableId,
        required this.name,
        required this.abilities,
        required this.lastUsedAt,
        required this.expiresAt,
        required this.createdAt,
        required this.updatedAt,
        required this.tokenable,
    });

    Token copyWith({
        int? id,
        String? tokenableType,
        String? tokenableId,
        String? name,
        List<String>? abilities,
        DateTime? lastUsedAt,
        dynamic expiresAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? tokenable,
    }) => 
        Token(
            id: id ?? this.id,
            tokenableType: tokenableType ?? this.tokenableType,
            tokenableId: tokenableId ?? this.tokenableId,
            name: name ?? this.name,
            abilities: abilities ?? this.abilities,
            lastUsedAt: lastUsedAt ?? this.lastUsedAt,
            expiresAt: expiresAt ?? this.expiresAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            tokenable: tokenable ?? this.tokenable,
        );

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json["id"],
        tokenableType: json["tokenable_type"],
        tokenableId: json["tokenable_id"],
        name: json["name"],
        abilities: List<String>.from(json["abilities"].map((x) => x)),
        lastUsedAt: DateTime.parse(json["last_used_at"]),
        expiresAt: json["expires_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tokenable: User.fromJson(json["tokenable"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tokenable_type": tokenableType,
        "tokenable_id": tokenableId,
        "name": name,
        "abilities": List<dynamic>.from(abilities.map((x) => x)),
        "last_used_at": lastUsedAt.toIso8601String(),
        "expires_at": expiresAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tokenable": tokenable.toJson(),
    };
}

class User {
    int id;
    String name;
    dynamic profilePicture;
    String username;
    String email;
    dynamic emailVerifiedAt;
    String userVerified;
    String role;
    String phoneNumber;
    dynamic phoneVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.profilePicture,
        required this.username,
        required this.email,
        required this.emailVerifiedAt,
        required this.userVerified,
        required this.role,
        required this.phoneNumber,
        required this.phoneVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    User copyWith({
        int? id,
        String? name,
        dynamic profilePicture,
        String? username,
        String? email,
        dynamic emailVerifiedAt,
        String? userVerified,
        String? role,
        String? phoneNumber,
        dynamic phoneVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        User(
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
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profile_picture"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userVerified: json["user_verified"],
        role: json["role"],
        phoneNumber: json["phone_number"],
        phoneVerifiedAt: json["phone_verified_at"],
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
        "phone_verified_at": phoneVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
