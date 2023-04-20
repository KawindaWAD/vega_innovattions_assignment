import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/usecases/usecase.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/user_registration_repository.dart';

class RegisterUser implements UseCase<bool, UserRegistrationInfo> {
  final UserRegistrationRepository userRegistrationRepository;

  RegisterUser({
    required this.userRegistrationRepository,
  });

  @override
  Future<Either<Failure, bool>> call(UserRegistrationInfo param) async {
    return await userRegistrationRepository.registerUser(param);
  }

}

class UserRegistrationInfo extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const UserRegistrationInfo({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, phoneNumber, password,];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    };
  }
}