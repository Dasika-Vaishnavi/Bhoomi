import 'dart:convert';

class UserModel {
  String name;
  String userId;
  int phoneNo;
  String email;
  UserModel({
    required this.name,
    required this.userId,
    required this.phoneNo,
    required this.email,
  });

  UserModel copyWith({
    String? name,
    String? userId,
    int? phoneNo,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'phoneNo': phoneNo,
      'email': email,
    };
  }

  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'] ?? '',
      userId: map['userId'] ?? '',
      phoneNo: map['phoneNo']?.toInt() ?? 0,
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, userId: $userId, phoneNo: $phoneNo, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.userId == userId &&
        other.phoneNo == phoneNo &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^ userId.hashCode ^ phoneNo.hashCode ^ email.hashCode;
  }
}
