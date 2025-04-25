
import 'package:movie_app/screen/home/model/genre/genre_model.dart';
import 'package:movie_app/screen/home/model/movie/movie_model.dart';

abstract class LocalRepo {

  Future<List<MovieModel>> getMovies();

  Future<void> setMovies({ required List<MovieModel> list});

  Future<List<GenreModel>> getGenre();

  Future<void> setGenre({ required List<GenreModel> list});

  Future<dynamic> setData(String key, dynamic value);

  Future<dynamic> getData(String key);

}