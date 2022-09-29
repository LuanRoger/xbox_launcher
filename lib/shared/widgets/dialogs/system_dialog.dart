import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';

class SystemDialog extends ContentDialog {
  SystemDialog(
      {super.key,
      required String title,
      required String content,
      required List<TextButton> actions})
      : super(title: Text(title), content: Text(content), actions: actions);

  Future show(BuildContext context) {
    return showDialog(
        context: context, barrierDismissible: false, builder: (_) => this);
  }
}
