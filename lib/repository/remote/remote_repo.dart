

import 'package:dartz/dartz.dart';

import '../../api_service/failure_response.dart';

abstract class RemoteRepo {
  Future<Either<FailureResponse, Map<String, dynamic>>?> getPopularMovies({required dynamic param});
  Future<Either<FailureResponse, Map<String, dynamic>>?> getTopRatedMovies({required dynamic param});
  Future<Either<FailureResponse, Map<String, dynamic>>?> getTopUpcomingMovies({required dynamic param});
  Future<Either<FailureResponse, Map<String, dynamic>>?> getGenre();
  Future<Either<FailureResponse, Map<String, dynamic>>?> discoverWithGenres({required dynamic param});
  Future<Either<FailureResponse, Map<String, dynamic>>?> searchMovie({required dynamic param});
}