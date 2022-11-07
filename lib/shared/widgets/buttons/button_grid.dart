import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class ButtonGridGroup {
  String? groupName;
  List<SystemButton> buttons;

  ButtonGridGroup({this.groupName, required this.buttons});
}

class ButtonGrid extends StatelessWidget {
  final List<ButtonGridGroup> buttons;
  final int? collectionFlex;
  final int? buttonsFlex;

  const ButtonGrid(
      {Key? key, required this.buttons, this.collectionFlex, this.buttonsFlex})
      : super(key: key);

  List<Widget> _generateButtonSet() {
    List<Widget> buttonSet = List<Widget>.empty(growable: true);

    buttons.forEach((buttonsGroup) {
      List<Widget> separatedButtons = List<Widget>.empty(growable: true);
      for (var button in buttonsGroup.buttons) {
        separatedButtons.addAll([
          Flexible(flex: buttonsFlex ?? 10, child: button),
          const Spacer(),
        ]);
      }

      buttonSet.addAll([
        Flexible(
          flex: collectionFlex ?? 10,
          child: InfoLabel(
            label: buttonsGroup.groupName ?? "",
            isHeader: true,
            labelStyle: AppTextStyle.BUTTON_GRID_COLLECTION_TITLE,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: separatedButtons,
            ),
          ),
        ),
        const Spacer()
      ]);
    });

    return buttonSet;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _generateButtonSet(),
    );
  }
}
