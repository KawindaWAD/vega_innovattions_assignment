import 'package:dartz/dartz.dart';

import '../entities/news_entity.dart';
import '../entities/news_param.dart';
import '../../../../core/errors/failures.dart';

abstract class NewsRepository {
  Future<Either<Failure, News>> getNewsData(NewsParams params);
}