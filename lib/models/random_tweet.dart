import 'package:html_character_entities/html_character_entities.dart';

RandomTweet randomTweetFromJson(Map<String, dynamic> json) =>
    RandomTweet.fromJson(json);

class RandomTweet {
  RandomTweet({
    required this.tweet,
    required this.cleanedTweet,
    required this.eval,
  });

  final String tweet;
  final String cleanedTweet;
  final double eval;

  RandomTweet copyWith({
    String? tweet,
    String? cleanedTweet,
    double? eval,
  }) =>
      RandomTweet(
        tweet: tweet ?? this.tweet,
        cleanedTweet: cleanedTweet ?? this.cleanedTweet,
        eval: eval ?? this.eval,
      );

  factory RandomTweet.fromJson(Map<String, dynamic> json) => RandomTweet(
        tweet: HtmlCharacterEntities.decode(json["tweet"]),
        cleanedTweet: json["cleaned_tweet"],
        eval: double.parse(json["eval"].toStringAsFixed(2)) * 100,
      );
}
