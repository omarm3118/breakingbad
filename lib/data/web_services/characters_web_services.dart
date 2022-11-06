import 'package:breaking_app/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return [];
    }
  }


  Future getCharacterQuote({required String characterName}) async {
    try {
      Response response = await dio
          .get('quote/random', queryParameters: {'author': characterName});
      return response.data;
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return [];
    }
  }
}
