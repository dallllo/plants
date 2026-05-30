import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/errors/failure.dart';
import 'package:plants_app/features/details/domain/entities/details_entity.dart';
import 'package:plants_app/features/home/domain/entities/home_entity.dart';
import 'package:plants_app/features/home/domain/repositories/home_repository_domain.dart';


@lazySingleton 
class HomeIdentifyPlantUseCase {
  final HomeRepositoryDomain _repositoryData;

  HomeIdentifyPlantUseCase(this._repositoryData);
   Future<Either<Failure, HomeEntity>> getHomeIdentifyPlant(String path) {
    return _repositoryData.identifyPlant(path);
  }
}

@lazySingleton 
class HomeGetPlantDetailsUseCase {
  final HomeRepositoryDomain _repositoryData;

  HomeGetPlantDetailsUseCase(this._repositoryData);
   Future<Either<Failure, DetailsEntity>> getHomeDetailsPlant(String name) {
    return _repositoryData.getDetails(name);
  }
     Future getidentifyPlant(String path) {
    return _repositoryData.identifyPlant(path);
  }
}