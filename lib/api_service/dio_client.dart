import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/utils/app_methods.dart';
import 'package:movie_app/utils/constants.dart';

import 'api_interceptor.dart';
import 'failure_response.dart';

@Injectable()
class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl))
      ..interceptors.add(ApiInterceptors());
  }

  Future<Either<FailureResponse, Map<String, dynamic>>?> request({
    required String url,
    Map<String, dynamic>? params,
  }) async {
    Response response;
    try {
      if (await AppMethods.checkConnectivity()) {
        response = await _dio.get(url, queryParameters: params);
        return right({"response": response.data});
      } else {
        return left(FailureResponse(true, "No Internet"));
      }
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 401 ||
          dioError.response?.statusCode == 302) {
        return left(FailureResponse(false, "Something went wrong"));
      }
    } catch (error) {
      return left(FailureResponse(false, error.toString()));
    }
    return null;
  }
}
