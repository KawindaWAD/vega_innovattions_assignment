import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_details_entity.dart';
import '../../domain/repositories/user_details_repository.dart';
import '../../domain/usecases/login_user.dart';
import '../datasources/user_details_local_data_source.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsLocalDataSource localDataSource;

  const UserDetailsRepositoryImpl(
      {required this.localDataSource});

  @override
  Future<Either<Failure, UserDetails>> loginUser(LoginDetails loginDetails) async {
    try {
      final userDetails = await localDataSource.getUserDetails(loginDetails);
      return Right(userDetails);
    } on ServerException catch (serverException) {
      if(serverException.unexpectedError) {
        //FireBaseServices.sendCrashReport(serverException, StackTrace.current);
      }
      return Left(ServerFailure(message: serverException.errorMessage));
    }
  }
}
