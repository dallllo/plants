import 'package:injectable/injectable.dart';
import 'package:plants_app/features/details/data/models/details_model.dart';


abstract class BaseDetailsRemoteDataSource {
  Future<DetailsModel> getDetails(String name);
}

@LazySingleton(as: BaseDetailsRemoteDataSource)
class DetailsRemoteDataSource implements BaseDetailsRemoteDataSource {
    @override
  Future<DetailsModel> getDetails(String name) async {
    try {
      return DetailsModel(name: name, description: "Plant Description: $name is a beautiful plant that thrives in well-drained soil and requires moderate watering. It prefers bright, indirect sunlight and can add a touch of greenery to any indoor space. With its vibrant foliage and easy care requirements, $name is a popular choice for plant enthusiasts and beginners alike.");
    } catch (error) {
     throw Exception(error);
    }
  }
}
