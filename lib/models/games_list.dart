import 'dart:convert';
import 'dart:io';
import 'package:xbox_launcher/models/game_model.dart';

class GamesList {
  String gamesFileList;
  Map<String, GameModel> gamesList;

  GamesList(this.gamesList, this.gamesFileList);

  factory GamesList.fromJson(String jsonFile) {
    String jsonText = File(jsonFile).readAsStringSync();
    return GamesList(jsonDecode(jsonText), jsonFile);
  }

  void toJson() {
    JsonEncoder jEncoder = const JsonEncoder.withIndent('  ');
    String jsonText = jEncoder.convert(gamesList);
    File(gamesFileList).writeAsStringSync(jsonText, mode: FileMode.writeOnly);
  }
}
