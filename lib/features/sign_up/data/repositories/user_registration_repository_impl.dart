import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/user_registration_repository.dart';
import '../../domain/usecases/register_user.dart';
import '../datasources/register_user_local_data_source.dart';

class UserRegistrationRepositoryImpl implements UserRegistrationRepository {
  final RegisterUserLocalDataSource registerUserLocalDataSource;

  const UserRegistrationRepositoryImpl({
    required this.registerUserLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> registerUser(UserRegistrationInfo info) async {
    try {
      await registerUserLocalDataSource.registerUser(info);
      return const Right(true);
    } on ServerException catch (serverException) {
      if(serverException.unexpectedError) {
        //FireBaseServices.sendCrashReport(serverException, StackTrace.current);
      }
      return Left(ServerFailure(message: serverException.errorMessage));
    }
  }
}