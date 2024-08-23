class UserModel {
    String message;
    Data data;

    UserModel({
        required this.message,
        required this.data,
    });

    UserModel copyWith({
        String? message,
        Data? data,
    }) => 
        UserModel(
            message: message ?? this.message,
            data: data ?? this.data,
        );
}

class Data {
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

    Data({
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

    Data copyWith({
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
        Data(
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
}
