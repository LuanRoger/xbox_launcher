import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false)
class GameModel {
  String gameTitle;
  String gamePublisher;
  String xcloudUrl;
  String tileGameImageUrl;
  String gameImageUrl;

  GameModel(this.gameTitle, this.gamePublisher, this.xcloudUrl,
      this.tileGameImageUrl, this.gameImageUrl);

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        json['gameTitle'] as String,
        json['gamePublisher'] as String,
        json['xcloudUrl'] as String,
        json['tileGameImageUrl'] as String,
        json['gameImageUrl'] as String,
      );
}
