import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class GameModel implements AppModel {
  @override
  late String name; //gameTitle
  @override
  AppType appType = AppType.GAME;

  late String gamePublisher;
  late String xcloudUrl;
  late String tileGameImageUrl;
  late String gameImageUrl;

  @override
  GameModel fromJson(Map<String, dynamic> json) {
    GameModel gameModel = GameModel();
    gameModel.name = json['gameTitle'] as String;
    gameModel.gamePublisher = json['gamePublisher'] as String;
    gameModel.xcloudUrl = json['xcloudUrl'] as String;
    gameModel.tileGameImageUrl = json['tileGameImageUrl'] as String;
    gameModel.gameImageUrl = json['gameImageUrl'] as String;

    return gameModel;
  }

  @override
  Map<String, dynamic> toJson() => {
        "gameTitle": name,
        "type": appType.index,
        "gamePublisher": gamePublisher,
        "xcloudUrl": xcloudUrl,
        "tileGameImageUrl": tileGameImageUrl,
        "gameImageUrl": gameImageUrl
      };
}
