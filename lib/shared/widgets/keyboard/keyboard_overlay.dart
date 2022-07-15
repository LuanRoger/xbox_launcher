// ignore_for_file: constant_identifier_names
import 'package:fluent_ui/fluent_ui.dart' hide Overlay;
import 'package:flutter/services.dart' hide KeyboardKey;
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/shared/system_text_box.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_key.dart';
import 'package:xbox_launcher/shared/widgets/models/overlay.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart' hide KeyboardKey;

enum _KeyboardLayout { ALPHABET, ALPHABET_CAPS, SYMBOLS }

class _KeyboardChars {
  static List<String> getKeys(_KeyboardLayout layout) {
    switch (layout) {
      case _KeyboardLayout.ALPHABET:
        return _alphabet;
      case _KeyboardLayout.ALPHABET_CAPS:
        return _alphabet.map((char) => char.toUpperCase()).toList();
      case _KeyboardLayout.SYMBOLS:
        return _symbols;
    }
  }

  static const List<String> _alphabet = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "q",
    "w",
    "e",
    "r",
    "t",
    "y",
    "u",
    "i",
    "o",
    "p",
    "a",
    "s",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "´",
    "z",
    "x",
    "c",
    "v",
    "b",
    "n",
    "m",
    ",",
    ".",
    "?"
  ];
  static const List<String> _symbols = [
    "!",
    "@",
    "#",
    "\$",
    "%",
    "&",
    "(",
    ")",
    "-",
    "_",
    "=",
    "+",
    "\\",
    ";",
    ":",
    "/",
    ".",
    "•",
    "©",
    "€",
    "£",
    "ɥ",
    "½",
    "<",
    ">",
    "[",
    "]",
    "{",
    "}",
    "|",
    "¦",
    "¶",
    "°",
    "~",
    "^",
    ".",
    "'",
    ","
  ];
}

class KeyboardOverlay implements Overlay, MappingDefinition {
  late GridView _currentKeyboardLayout;

  late _KeyboardLayout _currentKeyboardType;
  void Function(void Function())? _setNewLayout;
  final FocusNode _keyboardFocus = FocusNode(canRequestFocus: false);
  bool _keyboardLockState = true;
  void Function(void Function())? _updateKeyboardState;
  String? _initialStringMemento;

  void Function(bool cancel)? onFinish;
  TextEditingController controller;

  KeyboardOverlay({required this.controller, this.onFinish});

  void _changeKeyboardLayout(_KeyboardLayout _keyboardLayout) {
    var characters = _KeyboardChars.getKeys(_keyboardLayout);

    _currentKeyboardLayout = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 10,
            childAspectRatio: 1),
        itemBuilder: (_, index) {
          String char = characters[index];
          return KeyboardKey(
              text: char,
              onKeyPress: () => controller.text = controller.text + char);
        },
        itemCount: characters.length);
    _currentKeyboardType = _keyboardLayout;
  }

  void _switchKeyboardLayout() {
    _setNewLayout?.call(() => _changeKeyboardLayout(
        _currentKeyboardType == _KeyboardLayout.SYMBOLS
            ? _KeyboardLayout.ALPHABET
            : _KeyboardLayout.SYMBOLS));
  }

  void _switchLayoutToCaps() {
    _setNewLayout?.call(() => _changeKeyboardLayout(
        _currentKeyboardType != _KeyboardLayout.ALPHABET_CAPS
            ? _KeyboardLayout.ALPHABET_CAPS
            : _KeyboardLayout.ALPHABET));
  }

  void _switchKeyboardLocker() {
    _keyboardFocus.canRequestFocus = !_keyboardFocus.canRequestFocus;
    _updateKeyboardState
        ?.call(() => _keyboardLockState = !_keyboardFocus.canRequestFocus);
    if (!_keyboardLockState) {
      _keyboardFocus.requestFocus();
    }
  }

  void _backspace() {
    controller.text =
        controller.text.replaceRange(controller.text.length - 1, null, "");
  }

  void _space() {
    controller.text = controller.text + " ";
  }

  void _cancel(BuildContext context) {
    controller.text = _initialStringMemento!;
    undefineMapping(context);
    Navigator.pop(context);
  }

  void _finish(BuildContext context) {
    onFinish?.call(false);
    undefineMapping(context);
    Navigator.pop(context);
  }

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.saveAllCurrentAtMemento(context);

    KeyboardControllerActionManipulator.mapControllerActions(context, {
      ControllerButton.LEFT_SHOULDER: (_) => _switchKeyboardLayout(),
      ControllerButton.LEFT_THUMB: (_) => _switchLayoutToCaps(),
      ControllerButton.RIGHT_THUMB: (_) => _switchKeyboardLocker(),
      ControllerButton.X_BUTTON: (_) => _backspace(),
      ControllerButton.Y_BUTTON: (_) => _space(),
      ControllerButton.B_BUTTON: (context) => _cancel(context),
      ControllerButton.START: (context) => _finish(context)
    });
  }

  void undefineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.applyMementoInAll(context);
  }

  @override
  void show(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;
    _changeKeyboardLayout(_KeyboardLayout.ALPHABET);
    _initialStringMemento = String.fromCharCodes(controller.text.codeUnits);
    defineMapping(context);

    showGeneralDialog(
        context: context,
        pageBuilder: (buildContext, _, __) {
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
                        controller: controller,
                        focusNode: _keyboardFocus,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 4,
                                child: KeyboardKey(
                                  text: "Switch layout",
                                  onKeyPress: _switchKeyboardLayout,
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 8,
                                child: KeyboardKey(
                                  text: "Caps",
                                  onKeyPress: _switchLayoutToCaps,
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 9,
                                child: KeyboardKey(
                                    text: "Cancel",
                                    onKeyPress: () => _cancel(context))),
                          ],
                        )),
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
                                  return _currentKeyboardLayout;
                                },
                              ),
                            ),
                            const SizedBox(height: 3),
                            Expanded(
                                child: KeyboardKey(
                                    text: "Space", onKeyPress: () => _space()))
                          ],
                        )),
                    const SizedBox(width: 3),
                    Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 4,
                                child: KeyboardKey(
                                  text: "Backspace",
                                  onKeyPress: () => _backspace(),
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 8,
                                child: KeyboardKey(
                                  text: "Lock/Unlock",
                                  onKeyPress: () => _switchKeyboardLocker(),
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 9,
                                child: KeyboardKey(
                                  text: "Confirm",
                                  onKeyPress: () => _finish(context),
                                ))
                          ],
                        ))
                  ]),
                ),
              )
            ],
          );
        });
  }
}
