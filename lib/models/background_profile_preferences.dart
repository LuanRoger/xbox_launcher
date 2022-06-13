import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class BackgroundProfilePreferences {
  int backgroundColorIndex = 0;
  String? imageBackgroundPath;
  bool preferenceByImage = false;
  Color get solidColorBackground => AppColors.COLORS_LIST[backgroundColorIndex];

  BackgroundProfilePreferences(
      this.backgroundColorIndex, this.imageBackgroundPath);
  factory BackgroundProfilePreferences.fromJson(Map<String, dynamic> json) {
    BackgroundProfilePreferences backgroundProfilePreferences =
        BackgroundProfilePreferences(
            json["backgroundColorIndex"], json["imageBackgroundPath"]);
    backgroundProfilePreferences.preferenceByImage = json["preferenceByImage"];

    return backgroundProfilePreferences;
  }
  Map<String, dynamic> toJson() => {
        "backgroundColorIndex": backgroundColorIndex,
        "imageBackgroundPath": imageBackgroundPath,
        "preferenceByImage": preferenceByImage,
      };

  void reset() {
    backgroundColorIndex = 0;
    preferenceByImage = false;
    imageBackgroundPath = "";
  }
}
