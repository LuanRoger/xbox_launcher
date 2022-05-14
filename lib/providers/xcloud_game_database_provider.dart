import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/utils/xcloud_json_db_loader.dart';

class XcloudGameDatabaseProvider {
  late SharedPreferences _xcloudJsonDbPreferencesInstance;

  String get xcloudJsonDbPath =>
      _xcloudJsonDbPreferencesInstance.getString("xcloudJsonDbPath") ?? "";

  set xcloudJsonDbPath(String jsonFilePath) {
    _xcloudJsonDbPreferencesInstance.setString(
        "xcloudJsonDbPath", jsonFilePath);

    _jsonDbLoader ??= XcloudJsonDbLoader();
    _jsonDbLoader!.jsonFilePath = jsonFilePath;
    _updateJsonText();
  }

  XcloudJsonDbLoader? _jsonDbLoader;
  List<GameModel>? xcloudGames;

  Future init() async {
    _xcloudJsonDbPreferencesInstance = await SharedPreferences.getInstance();
    xcloudJsonDbPath =
        _xcloudJsonDbPreferencesInstance.getString("xcloudJsonDbPath") ?? "";
  }

  void deserializeGames() => xcloudGames = _jsonDbLoader!.deserializeAllJson();

  void _updateJsonText() async => await _jsonDbLoader?.readJsonFile();
}
