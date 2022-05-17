import 'package:json_annotation/json_annotation.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

@JsonSerializable(includeIfNull: false)
class GameModel implements AppModel {
  @override
  String name; //gameTitle
  @override
  AppType appType = AppType.GAME;

  String gamePublisher;
  String xcloudUrl;
  String tileGameImageUrl;
  String gameImageUrl;

  GameModel(this.name, this.gamePublisher, this.xcloudUrl,
      this.tileGameImageUrl, this.gameImageUrl);

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        json['gameTitle'] as String,
        json['gamePublisher'] as String,
        json['xcloudUrl'] as String,
        json['tileGameImageUrl'] as String,
        json['gameImageUrl'] as String,
      );
  Map<String, dynamic> toJson() => {
        "gameTitle": name,
        "appType": appType,
        "gamePublisher": gamePublisher,
        "xcloudUrl": xcloudUrl,
        "tileGameImageUrl": tileGameImageUrl,
        "gameImageUrl": gameImageUrl
      };
}
