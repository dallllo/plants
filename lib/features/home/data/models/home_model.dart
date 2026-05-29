import 'package:plants_app/features/home/domain/entities/home_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
abstract class HomeModel with _$HomeModel {
  const factory HomeModel({
    required String name,
    required String imageUrl,
    double? score,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, Object?> json) => _$HomeModelFromJson(json);
}



extension HomeModelMapper on HomeModel {
  HomeEntity toEntity() {
    return HomeEntity(name: name, imageUrl: imageUrl, score: score,);
  }
  }
