import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/screen/home/model/genre/genre_model.dart';
import 'package:movie_app/screen/home/model/movie/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

import 'local_repo.dart';

@LazySingleton(as: LocalRepo)

class LocalRepoImpl extends LocalRepo{
  @override
  Future<List<GenreModel>> getGenre() async{
    List<GenreModel> list = [];

    String data =  await getData(Constants.saveGenre) ?? "";

    if(data.isNotEmpty){
      List saved = jsonDecode(data);

      for(int i = 0; i<saved.length;i++){
        list.add(GenreModel.fromJson(saved[i]));
      }

    }

    return list;
  }

  @override
  Future<List<MovieModel>> getMovies() async{
    List<MovieModel> list = [];

    String data =  await getData(Constants.saveGenre) ?? "";

    if(data.isNotEmpty){
      List saved = jsonDecode(data);

      for(int i = 0; i<saved.length;i++){
        list.add(MovieModel.fromJson(saved[i]));
      }

    }
    return list;
  }

  @override
  Future<void> setGenre({required List<GenreModel> list}) async {
    await setData(Constants.saveGenre,jsonEncode(list.toList()));
  }

  @override
  Future<void> setMovies({required List<MovieModel> list}) async{
    await setData(Constants.saveMovie,jsonEncode(list.toList())) ;
  }

  @override
  Future setData(String key, value) async {
    var box = Hive.box(Constants.boxName);
    box.put(key, value);
  }

  @override
  Future getData(String key) async {
    var box = Hive.box(Constants.boxName);
    return box.get(key);
  }
}