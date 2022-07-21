import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class ExternalGameModel implements AppModel {
  @override
  late String name;
  @override
  AppType appType = AppType.EXTERNAL_APP;

  late String path;
  String? imagePath;
  String? iconUrl;

  @override
  ExternalGameModel fromJson(Map<String, dynamic> json) {
    ExternalGameModel externalGameModel = ExternalGameModel();
    externalGameModel.name = json["name"];
    externalGameModel.path = json["path"];
    externalGameModel.imagePath = json["imagePath"];
    externalGameModel.iconUrl = json["iconUrl"];

    return externalGameModel;
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "type": appType.index,
        "path": path,
        "imagePath": imagePath,
        "iconUrl": iconUrl
      };
}
