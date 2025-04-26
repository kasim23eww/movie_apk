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

    @Default(false)
    @JsonKey(includeFromJson: false,includeToJson: false)
    bool? isSelected
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

}