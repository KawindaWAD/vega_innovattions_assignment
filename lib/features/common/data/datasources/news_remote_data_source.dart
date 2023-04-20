import 'package:dio/dio.dart';
import 'package:vega_innovattions_assignmen/features/common/data/models/news_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/api_endpoints.dart';
import '../../domain/entities/news_param.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getNewsData(NewsParams params);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient dioClient;

  const NewsRemoteDataSourceImpl({
    required this.dioClient,
  });

  @override
  Future<NewsModel> getNewsData(NewsParams params) async {
    try {
      Response response = await dioClient.public.get(ApiEndpoints.topHeadLines, queryParameters: params.toMap());
      return newsFromJson(response.data);
    } on DioError catch (err) {
      throw ServerException.fromDioError(err);
    } catch (e) {
      throw ServerException(errorMessage: '$e', unexpectedError: true);
    }
  }
}