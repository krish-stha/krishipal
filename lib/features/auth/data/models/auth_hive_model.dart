// features/auth/data/models/auth_hive_model.dart
import 'package:hive/hive.dart';
import 'package:krishipal/core/constants/hive_table_constant.dart';
import 'package:krishipal/features/auth/domain/entities/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject {
  @HiveField(0)
  final String authId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String? password;

  @HiveField(5)
  final String? phoneNumber;

  @HiveField(6)
  final String? address; // Added address field

  @HiveField(7)
  final String? role;

  @HiveField(8)
  final String? profilePicture;

  @HiveField(9)
  final DateTime? deletedAt;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.phoneNumber,
    this.address, // Added address field
    this.role,
    this.profilePicture,
    this.deletedAt,
  }) : authId = authId ?? const Uuid().v4();

  /// Create Hive model from AuthEntity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      address: entity.address, // Added address field
      role: entity.role,
      profilePicture: entity.profilePicture,
      deletedAt: entity.deletedAt,
    );
  }

  /// Convert Hive model to AuthEntity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      address: address, // Added address field
      role: role,
      profilePicture: profilePicture,
      deletedAt: deletedAt,
    );
  }

  /// Convert a list of Hive models to list of entities
  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((e) => e.toEntity()).toList();
  }
}
