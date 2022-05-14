import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable(includeIfNull: false)
class GameModel {
  String gameTitle;
  String gamePublisher;
  String xcloudUrl;
  String tileGameImageUrl;
  String gameImageUrl;

  GameModel(this.gameTitle, this.gamePublisher, this.xcloudUrl,
      this.tileGameImageUrl, this.gameImageUrl);

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);
}
