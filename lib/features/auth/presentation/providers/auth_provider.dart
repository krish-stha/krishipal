// features/auth/presentation/providers/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:krishipal/features/auth/data/repositories/auth_repository.dart';
import 'package:krishipal/features/auth/domain/entities/auth_entity.dart';
import 'package:krishipal/features/auth/domain/usecases/login_usecase.dart';
import 'package:krishipal/features/auth/domain/usecases/register_usecase.dart';

import 'package:krishipal/features/auth/presentation/state/auth_state.dart';
import 'package:krishipal/features/auth/presentation/view_model/auth_view_model.dart';

// ========== AUTH USE CASES ==========
final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LoginUsecase(authRepository: authRepository);
});

final signupUsecaseProvider = Provider<SignupUsecase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return SignupUsecase(authRepository: authRepository);
});

// ========== AUTH VIEW MODEL ==========
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    loginUsecase: ref.read(loginUsecaseProvider),
    signupUsecase: ref.read(signupUsecaseProvider),
  ),
);

// ========== DERIVED PROVIDERS ==========
final authStatusProvider = Provider<AuthStatus>((ref) {
  return ref.watch(authViewModelProvider).status;
});

final currentUserProvider = Provider<AuthEntity?>((ref) {
  return ref.watch(authViewModelProvider).authEntity;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authViewModelProvider).errorMessage;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authViewModelProvider).status == AuthStatus.loading;
});

// ========== CURRENT USER DETAILS ==========
final currentUserNameProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.fullName;
});

final currentUserEmailProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.email;
});

final currentUserContactProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.phoneNumber;
});

final currentUserRoleProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role;
});
