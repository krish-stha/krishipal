// features/auth/domain/entities/auth_entity.dart
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? authId;
  final String fullName;
  final String email;
  final String username;
  final String? password;
  final String? phoneNumber;
  final String? address; // Added address field
  final String? role;
  final String? profilePicture;
  final DateTime? deletedAt;
  final String? countryCode;

  const AuthEntity({
    this.authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.phoneNumber,
    this.address, // Added address field
    this.role = 'user',
    this.profilePicture,
    this.deletedAt,
    this.countryCode,
  });

  // Copy with method for immutability
  AuthEntity copyWith({
    String? authId,
    String? fullName,
    String? email,
    String? username,
    String? password,
    String? phoneNumber,
    String? address, // Added address field
    String? role,
    String? profilePicture,
    DateTime? deletedAt,
    String? countryCode,
  }) {
    return AuthEntity(
      authId: authId ?? this.authId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address, // Added address field
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture,
      deletedAt: deletedAt ?? this.deletedAt,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'authId': authId,
      'fullName': fullName,
      'email': email,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address, // Added address field
      'role': role ?? 'user',
      'profilePicture': profilePicture,
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      authId: json['authId'],
      fullName: json['fullName'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'], // Added address field
      role: json['role'] ?? 'user',
      profilePicture: json['profilePicture'],
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
    authId,
    fullName,
    email,
    username,
    password,
    phoneNumber,
    address, // Added address field
    role,
    profilePicture,
    deletedAt,
  ];

  // Helper method to check if user is admin
  bool get isAdmin => role == 'admin';

  // Helper method to check if user is deleted
  bool get isDeleted => deletedAt != null;
}
