import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/button_svg_gen.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ShortcutsOverlay {
  final Map<ControllerButton, String> mapping;

  const ShortcutsOverlay(this.mapping, {Key? key});

  OverlayEntry generateButtons() {
    List<AssetImage> buttonImages =
        ButtonSvgGen.getSvgByButtons(mapping.keys.toList());

    List<Row> shortcutRow = List.empty(growable: true);
    int counter = 0;
    mapping.forEach((key, value) {
      shortcutRow.add(Row(
        children: [
          Image(
            image: buttonImages[counter],
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 5),
          Text(value)
        ],
      ));
    });

    return OverlayEntry(
        builder: (context) => Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: AppColors.ELEMENT_DARK_BG.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: shortcutRow)),
            ));
  }

  void show(BuildContext context) {
    final overlay = Overlay.of(context);

    overlay?.insert(generateButtons());
  }
}
