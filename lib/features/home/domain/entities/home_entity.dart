import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String name;
  final String imageUrl;
  final double? score;

  const HomeEntity({
    required this.name,
    required this.imageUrl, 
    this.score, 
  });

  @override
  List<Object?> get props => [name, imageUrl, score];
}
