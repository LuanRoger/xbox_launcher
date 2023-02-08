import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:url_launcher/url_launcher.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';

class ExternalSiteDialog extends SystemDialog {
  final Uri uri;

  ExternalSiteDialog(this.uri, {super.key})
      : super(
            textTitle: "Access a external site.",
            textContent: "Do you want to go to a external site?");

  @override
  SystemDialog? buildDialog(BuildContext context) {
    return SystemDialog(
      textTitle: textTitle,
      textContent: textContent,
      actions: [
        TextButton(
            title: "Confirm",
            onPressed: () async {
              await launchUrl(uri);
              Navigator.pop(context);
            }),
        TextButton(title: "Cancel", onPressed: () => Navigator.pop(context))
      ],
    );
  }
}
