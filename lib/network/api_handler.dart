import 'package:dio/dio.dart';
import 'package:infoviz_assign/models/random_tweet.dart';

import '../models/cryptocurrency_model.dart';

class APIHanlder {
  late Dio dio;

  APIHanlder() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://3.250.213.87',
      headers: {'content-Type': 'application/json'},
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    dio = Dio(options);
  }

  //btc, eth, sol
  Future<List<CryptocurrencyModel>> getCryptoData(String coinShortName) async {
    try {
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

      // reverse list so that fresh data goes in order from fresh to old
      assert(response.data is List<dynamic>);
      final List<dynamic> data = response.data.reversed.toList();

      return cryptocurrencyModelsFromJson(data);
    } on DioError catch (e) {
      print(e.message);
      return List.empty();
    } catch (e) {
      print('Exception unknown');
      return List.empty();
    }
  }

  Future<RandomTweet?> getRandomTweet(String coinShortName) async {
    try {
      final url = '/random_tweet_' + coinShortName;

      final response = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            print(status);
            return status! < 400;
          },
        ),
      );

      return randomTweetFromJson(response.data.first);
    } on DioError catch (e) {
      print(e.message);
      return null;
    } catch (e) {
      print('Exception unknown');
      return null;
    }
  }
}
