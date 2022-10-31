import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/button_svg_gen.dart';

class ShortcutsViewer extends StatelessWidget {
  final List<ShortcutInfo> mappedShortcuts;

  const ShortcutsViewer(this.mappedShortcuts, {super.key});

  List<Row> generateButtons() {
    List<AssetImage> buttonImages = ButtonsImageGen.getButtonsImage(
        mappedShortcuts
            .map((option) => option.controllerKeyboardPair.controllerButton)
            .toList());

    List<Row> shortcutRow = List.empty(growable: true);
    int counter = 0;
    for (ShortcutInfo sOption in mappedShortcuts) {
      if (!sOption.show) continue;

      shortcutRow.add(Row(
        children: [
          Image(
            image: buttonImages[counter],
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 5),
          Text(sOption.description)
        ],
      ));

      counter++;
    }

    return shortcutRow;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
          margin: const EdgeInsets.only(bottom: 20, right: 20),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(3.0)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: generateButtons())),
    );
  }
}
