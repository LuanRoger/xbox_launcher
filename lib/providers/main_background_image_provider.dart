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

  ImageProvider? _imageBackground;
  ImageProvider? get imageBackground => _imageBackground;
  set imageBackground(ImageProvider? image) {
    _imageBackground = image;
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
    imageBackground = null;
    notifyListeners();
  }

  Future init() async {
    backgroundSharedPreferences = await SharedPreferences.getInstance();

    _colorIndex =
        backgroundSharedPreferences.getInt("solidColorBackground") ?? 0;
    preferenceByImage =
        backgroundSharedPreferences.getBool("preferenceByImage") ?? false;
  }
}
