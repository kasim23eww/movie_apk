import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(name: "adult")
    required bool adult,
    @JsonKey(name: "backdrop_path")
    required String backdropPath,
    @JsonKey(name: "genre_ids")
    required List<int> genreIds,
    @JsonKey(name: "id")
    required int id,
    @JsonKey(name: "original_language")
    required String originalLanguage,
    @JsonKey(name: "original_title")
    required String originalTitle,
    @JsonKey(name: "overview")
    required String overview,
    @JsonKey(name: "popularity")
    required double popularity,
    @JsonKey(name: "poster_path")
    required String posterPath,
    @JsonKey(name: "release_date")
    required DateTime releaseDate,
    @JsonKey(name: "title")
    required String title,
    @JsonKey(name: "video")
    required bool video,
    @JsonKey(name: "vote_average")
    required double voteAverage,
    @JsonKey(name: "vote_count")
    required int voteCount,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);


  static List<MovieModel> getDummyList ()=> List.generate(15, (_){
    return MovieModel.fromJson(
      {
        "adult": false,
        "backdrop_path": "/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg",
        "genre_ids": [
          14,
          12,
          28
        ],
        "id": 324544,
        "original_language": "en",
        "original_title": "In the Lost Lands",
        "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power, where she and her guide, the drifter Boyce, must outwit and outfight both man and demon.",
        "popularity": 390.4471,
        "poster_path": "/t6HJH3gXtUqVinyFKWi7Bjh73TM.jpg",
        "release_date": "2025-02-27",
        "title": "In the Lost Lands",
        "video": false,
        "vote_average": 6.307,
        "vote_count": 283
      }
    );
  });

}
