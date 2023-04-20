import 'package:dartz/dartz.dart';
import 'package:vega_innovattions_assignmen/features/common/domain/usecases/usecase.dart';

import '../entities/news_entity.dart';
import '../entities/news_param.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/news_repository.dart';

/// Use case -> Fetching news data from server
class GetNews implements UseCase<News, NewsParams> {
  final NewsRepository newsRepository;

  const GetNews({
    required this.newsRepository,
  });

  @override
  Future<Either<Failure, News>> call(NewsParams param) async {
    return await newsRepository.getNewsData(param);
  }
}