import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';

class SystemDialog extends ContentDialog {
  final String textTitle;
  final String textContent;

  SystemDialog(
      {super.key,
      required this.textTitle,
      required this.textContent,
      List<TextButton>? actions})
      : super(title: Text(textTitle), content: Text(textContent), actions: actions);

  SystemDialog? buildDialog(BuildContext context) {
    //Virtual
    return null;
  }

  Future show(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => buildDialog(context) ?? this);
  }
}
