// features/auth/data/datasources/local/auth_local_datasource.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:krishipal/core/constants/hive_table_constant.dart';
import 'package:krishipal/core/services/storage/user_session.dart';
import 'package:krishipal/features/auth/data/models/auth_hive_model.dart';
import '../auth_datasource.dart';

// Provider
final authLocalDataSourceProvider = Provider<IAuthDatasource>((ref) {
  final userSessionService = ref.read(userSessionServiceProvider);
  return AuthLocalDatasource(userSessionService: userSessionService);
});

class AuthLocalDatasource implements IAuthDatasource {
  final UserSessionService _userSessionService;

  AuthLocalDatasource({required UserSessionService userSessionService})
    : _userSessionService = userSessionService;

  Box<AuthHiveModel> get _userBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  @override
  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      // Find user by email and password
      final users = _userBox.values.where(
        (user) =>
            user.email.toLowerCase() == email.toLowerCase() &&
            user.password == password,
      );

      if (users.isEmpty) return null;

      final user = users.first;

      // Save user session in SharedPreferences
      await _userSessionService.saveUserSession(
        userId: user.authId,
        email: user.email,
        name: user.fullName,
        contact: user.phoneNumber ?? '',
        address: user.address ?? '', // Use address from user
      );

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthHiveModel> signup(AuthHiveModel model) async {
    try {
      // Check if email already exists
      final emailExists = _userBox.values.any(
        (user) => user.email.toLowerCase() == model.email.toLowerCase(),
      );

      if (emailExists) {
        throw Exception('User already exists with this email');
      }

      // Save the user to Hive
      await _userBox.put(model.authId, model);

      // Save user session in SharedPreferences
      await _userSessionService.saveUserSession(
        userId: model.authId,
        email: model.email,
        name: model.fullName,
        contact: model.phoneNumber ?? '',
        address: model.address ?? '', // Use address from model
      );

      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      // Clear user session from SharedPreferences
      await _userSessionService.clearSession();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel?> getCurrentUser() async {
    try {
      // Check if user is logged in via SharedPreferences
      if (!_userSessionService.isLoggedIn()) {
        return null;
      }

      final userId = _userSessionService.getUserId();
      if (userId == null) return null;

      // Retrieve user from Hive using stored user ID
      return _userBox.get(userId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    try {
      return _userBox.values.any(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      return _userSessionService.isLoggedIn();
    } catch (e) {
      return false;
    }
  }
}
