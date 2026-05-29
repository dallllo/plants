import 'package:dio/dio.dart' as dio_package;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/network/dio_client.dart';
import 'package:plants_app/features/details/data/models/details_model.dart';
import 'package:plants_app/features/home/data/models/home_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<HomeModel> getHomeIdentify(String path);
  Future<DetailsModel> getDetails(String name);
}

@LazySingleton(as: BaseHomeRemoteDataSource)
class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  final DioClient dio;
  HomeRemoteDataSource(this.dio);
  @override
  Future<DetailsModel> getDetails(String name) async {
    final geminiKey = dotenv.env['GEMINI_API_KEY'];

    print('💕');
    print('GEMINI_API_KEY $geminiKey');
    print('______________-------- :) ----------- (: -------___________');

    if (geminiKey == null) {
      throw Exception("GEMINI_API_KEY is missing");
    }
    final response = await dio.dio.post(
      'https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash-lite:generateContent',
      queryParameters: {'key': geminiKey},
      data: {
        "contents": [
          {
            "parts": [
              {
                "text":
                    '''
Generate NEW and DIFFERENT plant care tips every time for: $name.
Each response must be unique and not repeated.

Be creative and vary the wording and facts.
اجب باللغه العربيه 
''',
              },
            ],
          },
        ],
      },
    );

print('❇️');
print(response);
print('❇️');

    final text = response.data['candidates'][0]['content']['parts'][0]['text'];
    return DetailsModel(name: name, description: text);
  }

  @override
  Future<HomeModel> getHomeIdentify(String path) async {
    final plantKey = dotenv.env['PLANTNET_API_KEY'];
    print('🚗');
    print("PLANTNET_API_KEY => $plantKey");
    final formData = dio_package.FormData.fromMap({
      'images': await dio_package.MultipartFile.fromFile(path),
      'organs': 'leaf',
    });
print('formData 😂😂😂 $formData');
    final response = await dio.dio.post(
      'https://my-api.plantnet.org/v2/identify/all',
      queryParameters: {'api-key': plantKey},
      data: formData,
    );
print('response 😂😂😂 $response');

    final results = response.data['results'];

    if (results == null || results.isEmpty) {
      throw Exception("No plant found");
    }

    final plantName = results[0]['species']['scientificNameWithoutAuthor'];
    final score = results[0]['score'];
    return HomeModel(name: plantName, imageUrl: path, score:  score);
  }
}
