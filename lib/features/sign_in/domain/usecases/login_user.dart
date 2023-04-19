import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_details_entity.dart';
import '../repositories/user_details_repository.dart';

class LoginUser implements UseCase<UserDetails, LoginDetails> {
  final UserDetailsRepository userDetailsRepository;

  LoginUser({required this.userDetailsRepository});

  @override
  Future<Either<Failure, UserDetails>> call(LoginDetails loginDetails) async {
    return await userDetailsRepository.loginUser(loginDetails);
  }
}

class LoginDetails extends Equatable {
  final String email;
  final String password;

  const LoginDetails({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
