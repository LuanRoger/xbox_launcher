import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcuts_viewer.dart';

abstract class ShortcutViewerSupport {
  ShortcutsViewer? _shortcutsOverlay;

  bool get supportShortcuts => _shortcutsOverlay != null;

  Widget? get shortcutOverlayWidget => _shortcutsOverlay;

  void updateShortcutsViewer(List<ShortcutInfo> shortcuts) {
    if (shortcuts.isEmpty) return;

    _shortcutsOverlay = ShortcutsViewer(shortcuts);
  }
}
