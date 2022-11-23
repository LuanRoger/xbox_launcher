import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart' hide KeyboardKey;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_images.dart';
import 'package:xbox_launcher/shared/enums/keyboard_layout.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_text_box.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_key.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keys_char.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class KeyboardOverlay implements MappingDefinition {
  TextEditingController controller;
  void Function(bool cancel)? onFinish;
  void Function(String value)? onChanged;

  late GridView currentKeyboardLayout;
  late KeyboardLayout currentKeyboardType;

  late final TextEditingController _textBufferController;
  late final FocusNode _textBoxFocus;

  void Function(void Function())? _setNewLayout;
  void Function(void Function())? _updateKeyboardState;
  bool _keyboardLockState = true;
  String? _initialStringMemento;

  KeyboardOverlay({required this.controller, this.onChanged, this.onFinish}) {
    _textBufferController = TextEditingController(text: controller.text);
    _textBoxFocus = FocusNode(canRequestFocus: false);
  }

  void dispose() {
    _textBufferController.dispose();
    _textBoxFocus.dispose();
  }

  void _changeKeyboardLayout(KeyboardLayout _keyboardLayout) {
    var characters = KeysChar.getKeys(_keyboardLayout);

    currentKeyboardLayout = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 10,
            childAspectRatio: 1),
        itemBuilder: (_, index) {
          String char = characters[index];
          return KeyboardKey(
              text: char,
              onKeyPress: () => _textBufferController.text =
                  _textBufferController.text + char);
        },
        itemCount: characters.length);
    currentKeyboardType = _keyboardLayout;
  }

  //#region Special Keyboard Keys Calls
  void _switchKeyboardLayout() {
    _setNewLayout?.call(() => _changeKeyboardLayout(
        currentKeyboardType == KeyboardLayout.SYMBOLS
            ? KeyboardLayout.ALPHABET
            : KeyboardLayout.SYMBOLS));
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) {
    return [
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.tab),
              ControllerButton.LEFT_SHOULDER),
          action: (_) => _switchKeyboardLayout()),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.capsLock),
              ControllerButton.LEFT_THUMB),
          action: (_) => _switchLayoutToCaps()),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.insert),
              ControllerButton.RIGHT_THUMB),
          action: (_) => _switchKeyboardLocker()),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.backspace),
              ControllerButton.X_BUTTON),
          action: (_) => _backspace()),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.space),
              ControllerButton.Y_BUTTON),
          action: (_) => _space()),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.BACK),
          action: (_) => _cancel(context)),
      ShortcutOption("",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.enter),
              ControllerButton.START),
          action: (_) => _finish(context))
    ];
  }

  void _switchLayoutToCaps() {
    _setNewLayout?.call(() => _changeKeyboardLayout(
        currentKeyboardType != KeyboardLayout.ALPHABET_CAPS
            ? KeyboardLayout.ALPHABET_CAPS
            : KeyboardLayout.ALPHABET));
  }

  void _switchKeyboardLocker() {
    _textBoxFocus.canRequestFocus = !_textBoxFocus.canRequestFocus;
    _updateKeyboardState
        ?.call(() => _keyboardLockState = !_textBoxFocus.canRequestFocus);
    if (!_keyboardLockState) {
      _textBoxFocus.requestFocus();
    }
  }

  void _backspace() {
    if (_textBufferController.text.isEmpty) return;
    _textBufferController.text = _textBufferController.text
        .replaceRange(_textBufferController.text.length - 1, null, "");
  }

  void _space() {
    _textBufferController.text = _textBufferController.text + " ";
  }

  void _cancel(BuildContext context) {
    _textBufferController.text = _initialStringMemento!;
    Navigator.pop(context);
  }

  void _finish(BuildContext context) {
    controller.text = _textBufferController.text;

    onFinish?.call(false);
    Navigator.pop(context);
  }
  //#endregion

  Future show(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    _changeKeyboardLayout(KeyboardLayout.ALPHABET);
    useKeyMapping(defineMapping(context)!, notify: false);

    return showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.8,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SystemTextBox(
                        controller: _textBufferController,
                        focusNode: _textBoxFocus,
                        onChanged: onChanged,
                        highlightColor:
                            context.read<ProfileProvider>().accentColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: StatefulBuilder(
                        builder: (_, setState) {
                          _updateKeyboardState ??= setState;
                          return Icon(_keyboardLockState
                              ? FluentIcons.lock
                              : FluentIcons.unlock);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(200, 23, 200, 23),
                  width: double.infinity,
                  height: screenHeight * 0.45,
                  color: Colors.black,
                  child: Row(children: [
                    Flexible(
                        flex: 1,
                        child: _LeftButtonsSet(
                            layoutKeyCallback: _switchKeyboardLayout,
                            capsKeyCallback: _switchLayoutToCaps,
                            cancelKeyCallback: _cancel)),
                    const SizedBox(width: 3),
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Flexible(
                              flex: 4,
                              child: StatefulBuilder(
                                builder: (_, updateKeyboard) {
                                  _setNewLayout ??= updateKeyboard;
                                  return currentKeyboardLayout;
                                },
                              ),
                            ),
                            const SizedBox(height: 3),
                            Expanded(
                                child: KeyboardKey(
                              text: "Space",
                              onKeyPress: () => _space(),
                              buttonImage: AppImages.Y_BUTTON_IMAGE,
                            ))
                          ],
                        )),
                    const SizedBox(width: 3),
                    Flexible(
                        flex: 1,
                        child: _RightButtonsSet(
                          backspaceKeyCallback: _backspace,
                          lockKeyCallback: _switchKeyboardLocker,
                          confirmKeyCallback: _finish,
                        ))
                  ]),
                ),
              )
            ],
          );
        });
  }
}

class _LeftButtonsSet extends StatelessWidget {
  final void Function() layoutKeyCallback;
  final void Function() capsKeyCallback;
  final void Function(BuildContext context) cancelKeyCallback;

  const _LeftButtonsSet(
      {required this.layoutKeyCallback,
      required this.capsKeyCallback,
      required this.cancelKeyCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 4,
            child: KeyboardKey(
              text: "Layout",
              onKeyPress: layoutKeyCallback,
              buttonImage: AppImages.LEFT_SHOLDER_IMAGE,
            )),
        const SizedBox(height: 3),
        Flexible(
            flex: 8,
            child: KeyboardKey(
              text: "Caps",
              onKeyPress: capsKeyCallback,
              buttonImage: AppImages.LEFT_THUMB_IMAGE,
            )),
        const SizedBox(height: 3),
        Flexible(
            flex: 9,
            child: KeyboardKey(
              text: "Cancel",
              onKeyPress: () => cancelKeyCallback(context),
              buttonImage: AppImages.BACK_BUTTON_IMAGE,
            )),
      ],
    );
  }
}

class _RightButtonsSet extends StatelessWidget {
  final void Function() backspaceKeyCallback;
  final void Function() lockKeyCallback;
  final void Function(BuildContext) confirmKeyCallback;

  const _RightButtonsSet(
      {required this.backspaceKeyCallback,
      required this.lockKeyCallback,
      required this.confirmKeyCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 4,
            child: KeyboardKey(
              text: "Backspace",
              onKeyPress: backspaceKeyCallback,
              buttonImage: AppImages.X_BUTTON_IMAGE,
            )),
        const SizedBox(height: 3),
        Flexible(
            flex: 8,
            child: KeyboardKey(
              text: "Lock/Unlock",
              onKeyPress: lockKeyCallback,
              buttonImage: AppImages.RIGHT_THUMB_IMAGE,
            )),
        const SizedBox(height: 3),
        Flexible(
            flex: 9,
            child: KeyboardKey(
              text: "Confirm",
              onKeyPress: () => confirmKeyCallback(context),
              buttonImage: AppImages.START_BUTTON_IMAGE,
            ))
      ],
    );
  }
}
