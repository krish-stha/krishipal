// features/auth/data/datasources/remote/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krishipal/core/api/api_client.dart';
import 'package:krishipal/core/api/api_endpoints.dart';
import 'package:krishipal/core/services/storage/user_session.dart';
import 'package:krishipal/features/auth/data/models/auth_api_model.dart';

final authRemoteDatasourceProvider = Provider<IAuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(userSessionServiceProvider),
  );
});

abstract class IAuthRemoteDatasource {
  Future<AuthApiModel?> login(String email, String password);
  Future<AuthApiModel> register(AuthApiModel user);
  Future<void> logout();
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthRemoteDatasource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
  }) : _apiClient = apiClient,
       _userSessionService = userSessionService;

  @override
  Future<AuthApiModel?> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.Login,
        data: {"email": email.toLowerCase(), "password": password},
      );

      if (response.data["success"] == true) {
        final userData = response.data["user"] ?? response.data["data"];

        if (userData == null) {
          throw Exception('No user data received from server');
        }

        final token = response.data["token"];
        final user = AuthApiModel.fromJson(userData);

        final contact = '${user.countryCode}${user.phone}';

        if (user.id == null || user.id!.isEmpty) {
          throw Exception('Invalid user data received');
        }

        await _userSessionService.saveUserSession(
          userId: user.id!,
          email: user.email,
          name: user.fullName,
          contact: contact,
          address: user.address ?? '',
        );

        await _secureStorage.write(key: "auth_token", value: token);
        return user;
      }

      final errorMessage =
          response.data["message"] ?? response.data["error"] ?? "Login failed";
      throw Exception(errorMessage);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      if (errorData is Map<String, dynamic>) {
        final errorMessage =
            errorData["message"] ??
            errorData["error"] ??
            e.message ??
            "Login failed";
        throw Exception(errorMessage);
      }
      throw Exception(e.message ?? "Network error during login");
    }
  }

  @override
  Future<AuthApiModel> register(AuthApiModel user) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.Register,
        data: user.toJson(),
      );

      if (response.data["success"] == true) {
        final userData = response.data["user"] ?? response.data["data"];

        if (userData == null) {
          throw Exception('Registration successful but no user data received');
        }

        return AuthApiModel.fromJson(userData);
      }

      final errorMessage =
          response.data["message"] ??
          response.data["error"] ??
          "Registration failed";

      throw Exception(errorMessage);
    } on DioException catch (e) {
      final errorData = e.response?.data;
      if (errorData is Map<String, dynamic>) {
        final errorMessage =
            errorData["message"] ??
            errorData["error"] ??
            e.message ??
            "Registration failed";
        throw Exception(errorMessage);
      }
      throw Exception(e.message ?? "Network error during registration");
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: "auth_token");
    await _userSessionService.clearSession();
  }
}
