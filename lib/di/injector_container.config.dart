// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/api_service/api_interceptor.dart' as _i317;
import 'package:movie_app/api_service/dio_client.dart' as _i257;
import 'package:movie_app/repository/local/local_repo.dart' as _i4;
import 'package:movie_app/repository/local/local_repo_impl.dart' as _i438;
import 'package:movie_app/repository/remote/remote_repo.dart' as _i435;
import 'package:movie_app/repository/remote/remote_repo_impl.dart' as _i265;
import 'package:movie_app/screen/home/bloc/home_bloc.dart' as _i130;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i257.DioClient>(() => _i257.DioClient());
  gh.singleton<_i317.ApiInterceptors>(() => _i317.ApiInterceptors());
  gh.lazySingleton<_i435.RemoteRepo>(
    () => _i265.RemoteRepoImpl(dioClient: gh<_i257.DioClient>()),
  );
  gh.lazySingleton<_i4.LocalRepo>(() => _i438.LocalRepoImpl());
  gh.factory<_i130.HomeBloc>(
    () => _i130.HomeBloc(
      localRepo: gh<_i4.LocalRepo>(),
      remoteRepo: gh<_i435.RemoteRepo>(),
    ),
  );
  return getIt;
}
