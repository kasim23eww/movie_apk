import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';


@freezed
abstract class GenreModel with _$GenreModel {
  const factory GenreModel({
    @JsonKey(name: "id")
    required int id,
    @JsonKey(name: "name")
    required String name,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

}