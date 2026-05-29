// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => _HomeModel(
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  score: (json['score'] as num?)?.toDouble(),
);

Map<String, dynamic> _$HomeModelToJson(_HomeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'score': instance.score,
    };
