import 'dart:convert';
import 'dart:io';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/utils/string_formatter.dart';

class XCloudJsonDbLoader {
  late String jsonFilePath;
  late String _jsonText;
  final int tileImageWidth = 300;
  final int tileImageHeight = 300;
  final int gameImageWidth = 1920;
  final int gameImageHeight = 1080;

  Future readJsonFile() async {
    File jsonFile = File(jsonFilePath);

    _jsonText = await jsonFile.readAsString();
  }

  List<GameModel> deserializeAllJson() {
    var jsonResult = json.decode(_jsonText);
    List<GameModel> gamesFromJson = List.empty(growable: true);
    for (var element in jsonResult) {
      element["tileGameImageUrl"] = StringFormatter.format(
          element["tileGameImageUrl"], [tileImageWidth, tileImageHeight]);
      element["gameImageUrl"] = StringFormatter.format(
          element["gameImageUrl"], [gameImageWidth, gameImageHeight]);

      gamesFromJson.add(GameModel().fromJson(element));
    }

    return gamesFromJson;
  }
}
