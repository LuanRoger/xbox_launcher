import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart'
    as xbox_button;

class SystemDialog extends ContentDialog {
  SystemDialog(
      {Key? key, required String title,
      required String content,
      required List<xbox_button.TextButton> actions})
      : super(key: key, title: Text(title), content: Text(content), actions: actions);

  Future show(BuildContext context) {
    return showDialog(
        context: context, barrierDismissible: false, builder: (_) => this);
  }
}
