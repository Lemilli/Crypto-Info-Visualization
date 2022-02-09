import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/cryptocurrency_model.dart';

class APIHanlder {
  var dio = Dio();

  Future<List<CryptocurrencyModel>> getCryptoData(String coinShortName) async {
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {
      'content-Type': 'application/json',
    };
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    try {
      // final url = kIsWeb
      //     ? 'http://127.0.0.1:8000/' + coinShortName
      //     : 'http://10.0.2.2:8000/' + coinShortName;  // android emulator localohst
      final url = 'http://3.250.213.87/' + coinShortName;

      final response = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            print(status);
            return status! < 400;
          },
        ),
      );

      return cryptocurrencyModelsFromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }
}
