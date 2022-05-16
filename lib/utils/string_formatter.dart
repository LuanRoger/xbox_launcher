import 'package:sprintf/sprintf.dart';

class StringFormatter {
  static String format(String text, List<Object> args) {
    return sprintf(text, args);
  }
}
