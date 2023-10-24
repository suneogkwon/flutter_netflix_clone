// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieModelImpl _$$MovieModelImplFromJson(Map<String, dynamic> json) =>
    _$MovieModelImpl(
      title: json['title'] as String,
      genre: json['genre'] as String,
      poster: json['poster'] as String,
      like: json['like'] as bool,
    );

Map<String, dynamic> _$$MovieModelImplToJson(_$MovieModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'genre': instance.genre,
      'poster': instance.poster,
      'like': instance.like,
    };
