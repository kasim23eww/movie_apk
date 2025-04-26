import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api_service/failure_response.dart';
import 'package:movie_app/repository/remote/remote_repo.dart';
import 'package:movie_app/utils/constants.dart';

import '../../api_service/dio_client.dart';

@LazySingleton(as: RemoteRepo)
class RemoteRepoImpl extends RemoteRepo {
  DioClient dioClient;

  RemoteRepoImpl({required this.dioClient});

  @override
  Future<Either<FailureResponse, Map<String, dynamic>>?> getGenre() async {
    return await dioClient.request(url: Constants.genre);
  }

  @override
  Future<Either<FailureResponse, Map<String, dynamic>>?> getPopularMovies({
    required param,
  }) async {
    return await dioClient.request(url: Constants.popular, params: param);
  }

  @override
  Future<Either<FailureResponse, Map<String, dynamic>>?> getTopRatedMovies({
    required param,
  }) async {
    return await dioClient.request(url: Constants.topRated, params: param);
  }

  @override
  Future<Either<FailureResponse, Map<String, dynamic>>?> getTopUpcomingMovies({
    required param,
  }) async {
    return await dioClient.request(url: Constants.upcoming, params: param);
  }
}
