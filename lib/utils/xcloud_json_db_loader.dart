import 'dart:convert';
import 'dart:io';

import 'package:xbox_launcher/models/game_model.dart';

class XcloudJsonDbLoader {
  late String jsonFilePath;
  String? _jsonText;

  Future readJsonFile() async {
    File jsonFile = File(jsonFilePath);

    _jsonText = await jsonFile.readAsString();
  }

  List<GameModel> deserializeAllJson() {
    var jsonResult = json.decode(_jsonText!);
    List<GameModel> gamesFromJson = List.empty(growable: true);
    for (var element in jsonResult) {
      gamesFromJson.add(GameModel.fromJson(element));
    }

    return gamesFromJson;
  }
}
