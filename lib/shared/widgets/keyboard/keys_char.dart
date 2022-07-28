import 'package:xbox_launcher/shared/enums/keyboard_layout.dart';

class KeysChar {
  static List<String> getKeys(KeyboardLayout layout) {
    switch (layout) {
      case KeyboardLayout.ALPHABET:
        return _alphabet;
      case KeyboardLayout.ALPHABET_CAPS:
        return _alphabet.map((char) => char.toUpperCase()).toList();
      case KeyboardLayout.SYMBOLS:
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