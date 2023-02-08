import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

abstract class SystemButtonBase implements FocableElement {
  Widget? content;
  double? height = 70.0;
  double? width = 170.0;

  SystemButtonBase(this.content, {this.width, this.height});
}
