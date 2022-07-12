// ignore_for_file: constant_identifier_names
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/system_text_box.dart';

enum _KeyboardLayout { ALPHABET, ALPHABET_CAPS, SYMBOLS }

class _KeyboardKeys {
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

class KeyboardOverlay {
  late GridView _currentKeyboardLayout;
  late _KeyboardLayout _currentKeyboardType;
  void Function(void Function())? _setNewLayout;

  void Function(bool cancel)? onFinish;

  KeyboardOverlay({this.onFinish});

  void _changeKeyboardLayout(
      _KeyboardLayout _keyboardLayout, TextEditingController toInsertChar) {
    var characters = _KeyboardKeys.getKeys(_keyboardLayout);

    _currentKeyboardLayout = GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 10,
            childAspectRatio: 1),
        itemBuilder: (_, index) {
          String char = characters[index];
          return _KeyboardButton(
              text: char,
              onKeyPress: () => toInsertChar.text = toInsertChar.text + char);
        },
        itemCount: characters.length);
    _currentKeyboardType = _keyboardLayout;
  }

  void show(BuildContext context, TextEditingController controller) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;
    _changeKeyboardLayout(_KeyboardLayout.ALPHABET, controller);

    showGeneralDialog(
        context: context,
        pageBuilder: (buildContext, _, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  height: 35,
                  width: screenWidth * 0.8,
                  child: SystemTextBox(
                    controller: controller,
                    focusNode: FocusNode(canRequestFocus: false),
                  )),
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
                                child: StatefulBuilder(
                                  builder: (_, updateLayoutSwitcher) {
                                    return _KeyboardButton(
                                      text: "Switch layout",
                                      onKeyPress: () {
                                        _setNewLayout?.call(() =>
                                            _changeKeyboardLayout(
                                                _currentKeyboardType ==
                                                        _KeyboardLayout.SYMBOLS
                                                    ? _KeyboardLayout.ALPHABET
                                                    : _KeyboardLayout.SYMBOLS,
                                                controller));
                                      },
                                    );
                                  },
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 8,
                                child: _KeyboardButton(
                                  text: "Cursor left",
                                  onKeyPress: () {},
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 9,
                                child: _KeyboardButton(
                                  text: "Caps",
                                  onKeyPress: () => _setNewLayout?.call(() =>
                                      _changeKeyboardLayout(
                                          _currentKeyboardType !=
                                                  _KeyboardLayout.ALPHABET_CAPS
                                              ? _KeyboardLayout.ALPHABET_CAPS
                                              : _KeyboardLayout.ALPHABET,
                                          controller)),
                                ))
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
                                child: _KeyboardButton(
                                    text: "Space",
                                    onKeyPress: () => controller.text =
                                        controller.text + " "))
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
                                child: _KeyboardButton(
                                  text: "Backspace",
                                  onKeyPress: () => controller.text =
                                      controller.text.replaceRange(
                                          controller.text.length - 1, null, ""),
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 8,
                                child: _KeyboardButton(
                                  text: "Cursor right",
                                  onKeyPress: () {},
                                )),
                            const SizedBox(height: 3),
                            Flexible(
                                flex: 9,
                                child: _KeyboardButton(
                                  text: "Confirm",
                                  onKeyPress: () {
                                    onFinish?.call(false);
                                    Navigator.pop(context);
                                  },
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

class _KeyboardButton extends StatelessWidget {
  String text;
  void Function() onKeyPress;

  _KeyboardButton({Key? key, required this.text, required this.onKeyPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: Align(alignment: Alignment.center, child: Text(text)),
      onPressed: onKeyPress,
      style: ButtonStyle(
          shape: ButtonState.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor: ButtonState.all(AppColors.ELEMENT_DARK_BG)),
    );
  }
}
