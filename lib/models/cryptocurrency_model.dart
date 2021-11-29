// To parse this JSON data, do
//
//     final cryptocurrencyModel = cryptocurrencyModelFromJson(jsonString);

import 'dart:convert';

List<CryptocurrencyModel> cryptocurrencyModelsFromJson(List<dynamic> str) {
  //final List<dynamic> decodedJson = json.decode(str);
  List<CryptocurrencyModel> results = List.empty(growable: true);
  for (Map<String, dynamic> element in str) {
    results.add(CryptocurrencyModel.fromJson(element));
  }

  return results;
}

// CryptocurrencyModel cryptocurrencyModelFromJson(String str) =>
//     CryptocurrencyModel.fromJson(json.decode(str));

// String cryptocurrencyModelToJson(CryptocurrencyModel data) =>
//     json.encode(data.toJson());

class CryptocurrencyModel {
  CryptocurrencyModel({
    required this.price,
    required this.priceChangePercentage24H,
    required this.highPrice24H,
    required this.lowPrice24H,
    required this.marketDominancePercentage,
    required this.keywordTweetNumber,
    required this.datetime,
    required this.semanticsAll,
    required this.semanticsPositiveTweets,
    required this.semanticsNegativeTweets,
    required this.circulatingSupply,
    required this.percentageOfPositiveTweets,
    required this.percentageOfNegativeTweets,
    required this.percentageOfNeutralTweets,
  });

  final double price;
  final double priceChangePercentage24H;
  final double highPrice24H;
  final double lowPrice24H;
  final double marketDominancePercentage;
  final int keywordTweetNumber;
  final DateTime datetime;
  final double semanticsAll;
  final double semanticsPositiveTweets;
  final double semanticsNegativeTweets;
  final double circulatingSupply;
  final double percentageOfPositiveTweets;
  final double percentageOfNegativeTweets;
  final double percentageOfNeutralTweets;

  factory CryptocurrencyModel.fromJson(Map<String, dynamic> map) {
    return CryptocurrencyModel(
      price: map["price"],
      priceChangePercentage24H: map["price_change_percentage_24h"],
      highPrice24H: map["high_price_24h"],
      lowPrice24H: map["low_price_24h"],
      marketDominancePercentage: map["market_dominance_percentage"],
      keywordTweetNumber: map["keyword_tweet_number"],
      datetime: DateTime.parse(map["datetime"]),
      semanticsAll: double.parse(map["semantics_all"].toStringAsFixed(2)),
      semanticsPositiveTweets: map["semantics_positive_tweets"],
      semanticsNegativeTweets: map["semantics_negative_tweets"],
      circulatingSupply: map["circulating_supply"],
      percentageOfPositiveTweets:
          double.parse(map["percentage_of_positive_tweets"].toStringAsFixed(2)),
      percentageOfNegativeTweets:
          double.parse(map["percentage_of_negative_tweets"].toStringAsFixed(2)),
      percentageOfNeutralTweets:
          double.parse(map["percentage_of_neutral_tweets"].toStringAsFixed(2)),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "price": price,
  //       "price_change_percentage_24h": priceChangePercentage24H,
  //       "high_price_24h": highPrice24H,
  //       "market_dominance_percentage": marketDominancePercentage,
  //       "keyword_tweet_number": keywordTweetNumber,
  //       "datetime": datetime.toIso8601String(),
  //       "semantics_all": semanticsAll,
  //       "semantics_positive_tweets": semanticsPositiveTweets,
  //       "semantics_negative_tweets": semanticsNegativeTweets,
  //       "circulating_supply": circulatingSupply,
  //     };
}
