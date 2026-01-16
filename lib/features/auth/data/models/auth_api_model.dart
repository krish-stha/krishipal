// features/auth/data/models/auth_api_model.dart
import 'package:krishipal/features/auth/domain/entities/auth_entity.dart';

class AuthApiModel {
  final String? id;
  final String fullName;
  final String email;
  final String username;
  final String? password;
  final String countryCode;
  final String phone;
  final String? address;
  final String? role;
  final String? profilePicture;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AuthApiModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    required this.countryCode,
    required this.phone,
    this.address,
    this.role,
    this.profilePicture,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor that can handle different response formats
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      id: json['_id'] ?? json['id'], // Handle both _id and id
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      username:
          json['email'] ??
          json['username'] ??
          '', // Try email first, then username
      password: json['password'],
      countryCode: json['countryCode'] ?? '+977', // Default to Nepal
      phone: json['phone'] ?? '',
      address: json['address'],
      role: json['role'] ?? 'user',
      profilePicture: json['profile_picture'] ?? json['profilePicture'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : (json['deletedAt'] != null
                ? DateTime.parse(json['deletedAt'])
                : null),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'username': email, // Send email as username
      'password': password,
      'countryCode': countryCode,
      'phone': phone,
      'address': address,
      'role': role ?? 'user',
    };
  }

  AuthEntity toEntity() {
    return AuthEntity(
      authId: id,
      fullName: fullName,
      email: email,
      username: username.isNotEmpty
          ? username
          : email, // Use username if available, else email
      password: password,
      phoneNumber: '$countryCode$phone', // Combine for local storage
      address: address,
      role: role,
      profilePicture: profilePicture,
      deletedAt: deletedAt,
    );
  }

  factory AuthApiModel.fromEntity(AuthEntity entity) {
    // Parse phone number into countryCode and phone
    String countryCode = '+977'; // Default
    String phone = '';

    if (entity.phoneNumber != null && entity.phoneNumber!.isNotEmpty) {
      // Extract country code
      final phoneNumber = entity.phoneNumber!;

      // Remove all spaces
      final cleanNumber = phoneNumber.replaceAll(' ', '');

      // Extract country code (assuming it starts with + and has 1-4 digits)
      if (cleanNumber.startsWith('+')) {
        // Find the end of country code (after + sign)
        // Country codes are typically 1-4 digits including the +
        final regex = RegExp(r'^(\+\d{1,3})');
        final match = regex.firstMatch(cleanNumber);

        if (match != null) {
          countryCode = match.group(0)!;
          phone = cleanNumber.substring(countryCode.length);
        } else {
          // If no proper country code, use default
          phone = cleanNumber;
        }
      } else {
        // No country code prefix
        phone = cleanNumber;
      }
    }

    return AuthApiModel(
      id: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      username: entity.username, // Use the username from entity
      password: entity.password,
      countryCode: countryCode,
      phone: phone,
      address: entity.address,
      role: entity.role,
      profilePicture: entity.profilePicture,
      deletedAt: entity.deletedAt,
    );
  }
}
