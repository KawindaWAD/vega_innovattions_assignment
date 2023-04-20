import 'package:dartz/dartz.dart';
import 'package:vega_innovattions_assignmen/core/errors/failures.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_param.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, News>> getNewsData(NewsParams params) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final info = await remoteDataSource.getNewsData(params);
        return Right(info.toEntity());
      } on ServerException catch (serverException) {
        if(serverException.unexpectedError) {
          /// In here we can implement firebase crashlytics services
        }
        return Left(ServerFailure(message: serverException.errorMessage));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}