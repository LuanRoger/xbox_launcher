import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/alert_bar/alert_bar_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

import '../models/app_models/external_game_model.dart';

class AddExternalGamePage extends XboxPageStateful {
  AddExternalGamePage({Key? key})
      : super(key: key, pageKeysAction: {
          ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
        });

  @override
  State<AddExternalGamePage> createState() => _AddExternalGamePageState();
}

class _AddExternalGamePageState extends XboxPageState<AddExternalGamePage> {
  late final TextEditingController gameNameController;
  late final TextEditingController gamePathController;
  late final TextEditingController gameImagePathController;
  late final TextEditingController gameIconUrlController;

  late Image gameImagePreview;
  late Image gameIconPreview;

  @override
  void initState() {
    super.initState();
    gameNameController = TextEditingController();
    gamePathController = TextEditingController();
    gameImagePathController = TextEditingController();
    gameIconUrlController = TextEditingController();

    gameIconPreview = _getGameIcon(gameIconUrlController.text);
    gameImagePreview = _getGameImage(gameImagePathController.text);
  }

  @override
  void dispose() {
    super.dispose();
    gameNameController.dispose();
    gamePathController.dispose();
    gameImagePathController.dispose();
    gameIconUrlController.dispose();
  }

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(context, {
      ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
          ControllerButton.B_BUTTON): (context) => Navigator.pop(context)
    });
  }

  Image _getGameIcon(String url) => Image.network(
        url,
        errorBuilder: (_, __, ___) => const Icon(FluentIcons.photo_error),
      );
  Image _getGameImage(String filePath) => Image.file(
        File(filePath),
        errorBuilder: (_, __, ___) => const Icon(FluentIcons.photo_error),
        fit: BoxFit.fill,
      );

  @override
  Widget virtualBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(children: [
              Flexible(
                flex: 5,
                child: InfoLabel(
                  label: "*Game name:",
                  child: KeyboardButton(
                      placeholder: "Game name", controller: gameNameController),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 5,
                child: InfoLabel(
                  label: "*Game path:",
                  child: KeyboardButton(
                      placeholder: "Game path", controller: gamePathController),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 5,
                child: InfoLabel(
                  label: "Game image path:",
                  child: KeyboardButton(
                    placeholder: "Game image path",
                    controller: gameImagePathController,
                    onFinish: ((cancel) {
                      if (cancel) return;

                      setState(() => gameImagePreview =
                          _getGameImage(gameImagePathController.text));
                    }),
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 5,
                child: InfoLabel(
                  label: "Game icon URL:",
                  child: KeyboardButton(
                    placeholder: "Game icon URL",
                    controller: gameIconUrlController,
                    onFinish: (cancel) {
                      if (cancel) return;

                      setState(() => gameIconPreview =
                          _getGameIcon(gameIconUrlController.text));
                    },
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      title: "Confirm",
                      onPressed: () {
                        if (gameNameController.text.isEmpty ||
                            gamePathController.text.isEmpty) {
                          AlertBarOverlay("Can't be empty.",
                                  "The Game name and Game path can't be empty.",
                                  severity: InfoBarSeverity.error)
                              .show(context);
                          return;
                        }

                        var profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);
                        ExternalGameModel externalGameModel =
                            ExternalGameModel();
                        externalGameModel.name = gameNameController.text;
                        externalGameModel.path = gamePathController.text;
                        externalGameModel.imagePath =
                            gameImagePathController.text.isEmpty
                                ? null
                                : gameImagePathController.text;
                        externalGameModel.iconUrl =
                            gameIconUrlController.text.isEmpty
                                ? null
                                : gameIconUrlController.text;

                        profileProvider.addExternalGame(externalGameModel);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                        title: "Cancel",
                        onPressed: () => Navigator.pop(context))
                  ],
                ),
              )
            ]),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.5)),
                      width: 32,
                      height: 32,
                      child: gameIconPreview),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5)),
                    width: double.infinity,
                    height: 300,
                    child: gameImagePreview,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
