import 'package:dio/dio.dart';

import '../utils/api_endpoints.dart';
import '../utils/const/const.dart';

class DioClient {
  Dio public;

  DioClient({required this.public,}) {
    public.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: 15000, // in milliseconds
      receiveTimeout: 15000, // in milliseconds
      responseType: ResponseType.plain,
      headers: {
        "X-Api-Key" : apiKey
      }
    );
  }
}