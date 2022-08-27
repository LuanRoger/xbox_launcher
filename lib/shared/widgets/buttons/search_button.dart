import 'package:fluent_ui/fluent_ui.dart' hide IconButton;
import 'package:xbox_launcher/shared/widgets/buttons/icon_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class SearchButton extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(bool)? onFinish;
  final double? width;
  final double? height;

  const SearchButton(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.onFinish,
      this.width = 100.0,
      this.height = 30.0})
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
