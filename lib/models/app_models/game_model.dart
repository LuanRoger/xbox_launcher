import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class GameModel implements AppModel {
  @override
  late String name; //gameTitle
  @override
  AppType appType = AppType.GAME;

  late String gamePublisher;
  late String gameDeveloper;
  late List<String> gameGenres;
  late String releaseDate;
  late ExtraGameProperties extraGameProperties;
  late String xcloudUrl;
  late String tileGameImageUrl;
  late String gameImageUrl;
  late String storeUrl;

  @override
  GameModel fromJson(Map<String, dynamic> json) {
    GameModel gameModel = GameModel();
    gameModel.name = json['gameTitle'] as String;
    gameModel.gamePublisher = json['gamePublisher'] as String;
    gameModel.gameDeveloper = json["gameDeveloper"] as String;
    gameModel.gameGenres =
        (json["gameGenres"] as List<dynamic>).map((e) => e as String).toList();
    gameModel.releaseDate = json["releaseDate"] as String;
    gameModel.extraGameProperties =
        ExtraGameProperties.fromJson(json["extraGameProperties"]);
    gameModel.xcloudUrl = json['xcloudUrl'] as String;
    gameModel.tileGameImageUrl = json['tileGameImageUrl'] as String;
    gameModel.gameImageUrl = json['gameImageUrl'] as String;
    gameModel.storeUrl = json["storeUrl"] as String;

    return gameModel;
  }

  @override
  Map<String, dynamic> toJson() => {
        "gameTitle": name,
        "type": appType.index,
        "gamePublisher": gamePublisher,
        "gameDeveloper": gameDeveloper,
        "gameGenres": gameGenres,
        "releaseDate": releaseDate,
        "extraGameProperties": extraGameProperties.toJson(),
        "xcloudUrl": xcloudUrl,
        "tileGameImageUrl": tileGameImageUrl,
        "gameImageUrl": gameImageUrl,
        "storeUrl": storeUrl
      };
}

class ExtraGameProperties {
  bool isInGamePass;
  bool controllerSupport;
  bool touchSupport;

  ExtraGameProperties(
      {this.isInGamePass = false,
      this.controllerSupport = false,
      this.touchSupport = false});

  Map<String, dynamic> toJson() => {
        "isInGamePass": isInGamePass,
        "controllerSupport": controllerSupport,
        "touchControllerSupport": touchSupport
      };
  factory ExtraGameProperties.fromJson(Map<String, dynamic> json) =>
      ExtraGameProperties(
          isInGamePass: json["isInGamePass"] as bool,
          controllerSupport: json["controllerSupport"] as bool,
          touchSupport: json["touchControllerSupport"] as bool);

  AppBadgeInfo toBadgeInfo() => AppBadgeInfo(
      controllerSupport: controllerSupport,
      isInGamePass: isInGamePass,
      touchSupport: touchSupport);
}
