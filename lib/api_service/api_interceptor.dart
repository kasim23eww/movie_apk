import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/utils/constants.dart';

@Singleton()
class ApiInterceptors extends InterceptorsWrapper {
  ApiInterceptors();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final method = options.method;
    final uri = options.uri;
    options.headers['Authorization'] = "Bearer ${Constants.apiKey}";

    options.headers['Accept'] = "application/json";

    logger.log(
      "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers}\n QueryParam: ${options.queryParameters}",
    );
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;

    logger.log(
      "✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: ${response.data}",
    );

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode!;
    final uri = err.requestOptions.path;
    logger.log(
      "⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: ${err.response?.data}",
    );
    super.onError(err, handler);
  }
}
