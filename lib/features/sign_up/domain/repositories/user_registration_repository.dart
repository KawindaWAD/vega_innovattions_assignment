import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../usecases/register_user.dart';

abstract class UserRegistrationRepository {
  Future<Either<Failure, bool>> registerUser(UserRegistrationInfo info);
}