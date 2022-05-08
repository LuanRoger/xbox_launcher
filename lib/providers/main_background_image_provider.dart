import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class MainBackgroundImageProvider extends ChangeNotifier {
  late SharedPreferences backgroundSharedPreferences;

  late int _colorIndex;
  Color get solidColorBackground => AppColors.COLORS_LIST[_colorIndex];
  set colorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    backgroundSharedPreferences.setInt("solidColorBackground", colorIndex);
    notifyListeners();
  }

  late String _imageBackgroundPath;
  String get imageBackgroundPath => _imageBackgroundPath;
  set imageBackgroundPath(String imagePath) {
    _imageBackgroundPath = imagePath;
    backgroundSharedPreferences.setString("imageBackgroundPath", imagePath);
    notifyListeners();
  }

  bool _acrylic = false;
  bool get acrylic => _acrylic;
  set acrylic(bool acrylic) {
    _acrylic = acrylic;
    notifyListeners();
  }

  late bool _preferenceByImage;
  bool get preferenceByImage => _preferenceByImage;
  set preferenceByImage(bool preferenceByImage) {
    _preferenceByImage = preferenceByImage;
    backgroundSharedPreferences.setBool("preferenceByImage", preferenceByImage);
  }

  void resetBackground() {
    colorIndex = 0;
    imageBackgroundPath = "";
    notifyListeners();
  }

  Future init() async {
    backgroundSharedPreferences = await SharedPreferences.getInstance();

    colorIndex =
        backgroundSharedPreferences.getInt("solidColorBackground") ?? 0;
    preferenceByImage =
        backgroundSharedPreferences.getBool("preferenceByImage") ?? false;
    imageBackgroundPath =
        backgroundSharedPreferences.getString("imageBackgroundPath") ?? "";
  }

  void reset() {
    colorIndex = 0;
    preferenceByImage = false;
    imageBackgroundPath = "";
  }
}
