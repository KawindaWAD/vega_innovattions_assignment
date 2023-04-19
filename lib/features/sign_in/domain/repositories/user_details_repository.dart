import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_details_entity.dart';
import '../usecases/login_user.dart';

abstract class UserDetailsRepository {
  Future<Either<Failure, UserDetails>> loginUser(LoginDetails loginDetails);
}