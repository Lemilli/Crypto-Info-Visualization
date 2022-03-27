import 'package:infoviz_assign/models/cryptocurrency_model.dart';
import 'package:infoviz_assign/models/random_tweet.dart';
import 'package:infoviz_assign/network/api_handler.dart';

class CryptoRepository {
  CryptoRepository();

  final _apiHanlder = APIHanlder();

  Future<List<CryptocurrencyModel>> getBitcoins() =>
      _apiHanlder.getCryptoData('btc');
  Future<List<CryptocurrencyModel>> getEthereums() =>
      _apiHanlder.getCryptoData('eth');
  Future<List<CryptocurrencyModel>> getSolanas() =>
      _apiHanlder.getCryptoData('sol');

  Future<RandomTweet?> getRandomTweetBTC() => _apiHanlder.getRandomTweet('btc');
  Future<RandomTweet?> getRandomTweetETH() => _apiHanlder.getRandomTweet('eth');
  Future<RandomTweet?> getRandomTweetSOL() => _apiHanlder.getRandomTweet('sol');
}
