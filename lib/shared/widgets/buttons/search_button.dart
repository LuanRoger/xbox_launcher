import 'package:fluent_ui/fluent_ui.dart' hide IconButton;
import 'package:xbox_launcher/shared/widgets/buttons/icon_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class SearchButton extends StatelessWidget {
  TextEditingController controller;
  void Function(String)? onChanged;
  void Function(bool)? onFinish;
  double? width;
  double? height;

  SearchButton(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.onFinish,
      this.width,
      this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: FluentIcons.search,
        width: width,
        height: height,
        onPressed: () => KeyboardOverlay(
                controller: controller,
                onFinish: onChanged == null ? onFinish : null,
                onChanged: onFinish == null ? onChanged : null)
            .show(context));
  }
}
