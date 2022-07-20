import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/external_game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class AddExternalGamePage extends XboxPageStateless {
  TextEditingController gameNameController = TextEditingController();
  TextEditingController gamePathController = TextEditingController();

  AddExternalGamePage({Key? key}) : super(key: key);

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(context, {
      ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
          ControllerButton.B_BUTTON): (context) => Navigator.pop(context)
    });
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(children: [
        InfoLabel(
          label: "Game name",
          child: KeyboardButton(
              placeholder: "Game name", controller: gameNameController),
        ),
        InfoLabel(
          label: "Game path",
          child: KeyboardButton(
              placeholder: "Game path", controller: gamePathController),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              title: "Confirm",
              onPressed: () {
                if (gameNameController.text.isEmpty ||
                    gamePathController.text.isEmpty) {
                  //TODO: Create alert system
                  return;
                }

                var profileProvider =
                    Provider.of<ProfileProvider>(context, listen: false);
                ExternalGameModel externalGameModel = ExternalGameModel();
                externalGameModel.name = gameNameController.text;
                externalGameModel.path = gamePathController.text;

                profileProvider.addExternalGame(externalGameModel);
                Navigator.pop(context);
              },
            ),
            TextButton(title: "Cancel", onPressed: () => Navigator.pop(context))
          ],
        )
      ]),
    );
  }
}
