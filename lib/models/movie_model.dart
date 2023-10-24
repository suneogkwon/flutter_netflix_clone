import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(includeFromJson: false, includeToJson: false)
    DocumentReference<Map<String, dynamic>>? reference,
    required String title,
    required String genre,
    required String poster,
    required bool like,
  }) = _MovieModel;

  factory MovieModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data();
    return MovieModel(
      reference: snapshot.reference,
      title: json['title'],
      genre: json['genre'],
      poster: json['poster'],
      like: json['like'],
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
