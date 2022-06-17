import 'package:window_manager/window_manager.dart';

class VideoPreferences {
  bool _fullscreen;
  bool get fullscreen => _fullscreen;
  set fullscreen(bool fullscreen) {
    _fullscreen = fullscreen;

    _updateWindow();
  }

  late WindowOptions windowOptions;

  VideoPreferences(this._fullscreen);
  factory VideoPreferences.fromJson(Map<String, dynamic> json) =>
      VideoPreferences(json["fullscreen"]);
  Map<String, dynamic> toJson() => {"fullscreen": _fullscreen};

  Future init() async {
    windowOptions = WindowOptions(center: true, fullScreen: _fullscreen);
    _updateWindow();
  }

  void _updateWindow() {
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setFullScreen(_fullscreen);
    });
  }
}
