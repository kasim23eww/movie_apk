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

}
