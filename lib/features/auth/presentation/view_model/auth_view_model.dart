// features/auth/presentation/view_model/auth_view_model.dart
import 'package:flutter_riverpod/legacy.dart';
import 'package:krishipal/features/auth/domain/usecases/login_usecase.dart';
import 'package:krishipal/features/auth/domain/usecases/register_usecase.dart';
import 'package:krishipal/features/auth/presentation/state/auth_state.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final LoginUsecase _loginUsecase;
  final SignupUsecase _signupUsecase;

  AuthViewModel({
    required LoginUsecase loginUsecase,
    required SignupUsecase signupUsecase,
  }) : _loginUsecase = loginUsecase,
       _signupUsecase = signupUsecase,
       super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      final result = await _loginUsecase(
        LoginParams(email: email, password: password),
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          );
        },
        (authEntity) {
          state = state.copyWith(
            status: AuthStatus.authenticated,
            authEntity: authEntity,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String username,
    required String password,
    required String phoneNumber,
    required String countryCode,
    required String? address,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      final result = await _signupUsecase(
        SignupParams(
          fullName: fullName,
          email: email.toLowerCase(),
          username: email.toLowerCase(),
          password: password,
          phoneNumber: phoneNumber,
          countryCode: countryCode,
          address: address,
        ),
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          );
        },
        (success) {
          if (success) {
            state = state.copyWith(
              status: AuthStatus.registered,
              errorMessage: "Registration Successful! You can now login.",
            );
          } else {
            state = state.copyWith(
              status: AuthStatus.error,
              errorMessage: "Registration failed. Please try again.",
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      authEntity: null,
      errorMessage: null,
    );
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }
}
