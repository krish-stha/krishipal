// features/auth/domain/usecases/signup_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:krishipal/core/error/failures.dart';
import 'package:krishipal/core/usecases/app_usecase.dart';
import 'package:krishipal/features/auth/domain/entities/auth_entity.dart';
import 'package:krishipal/features/auth/domain/repositories/auth_repository.dart';

// features/auth/domain/usecases/signup_usecase.dart
class SignupParams extends Equatable {
  final String fullName;
  final String email;
  final String username;
  final String password;
  final String phoneNumber; // Just the phone number
  final String countryCode; // Country code separately
  final String? address;
  final String role;

  const SignupParams({
    required this.fullName,
    required this.email,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.countryCode, // Added country code
    this.address,
    this.role = "user",
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    username,
    password,
    phoneNumber,
    countryCode,
    address,
    role,
  ];
}

class SignupUsecase implements UsecaseWithParams<bool, SignupParams> {
  final IAuthRepository _authRepository;

  SignupUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(SignupParams params) {
    final entity = AuthEntity(
      authId: null,
      fullName: params.fullName,
      email: params.email,
      username: params.username,
      password: params.password,
      phoneNumber:
          '${params.countryCode}${params.phoneNumber}', // Combine for local storage
      address: params.address,
      role: params.role,
      profilePicture: null,
      deletedAt: null,
    );

    return _authRepository.register(entity);
  }
}
