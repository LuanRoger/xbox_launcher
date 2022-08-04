import 'package:fluent_ui/fluent_ui.dart' hide Overlay;
import 'package:xbox_launcher/shared/widgets/models/overlay.dart';

class AlertBarOverlay extends Overlay {
  String title;
  String content;
  InfoBarSeverity severity;

  AlertBarOverlay(this.title, this.content,
      {this.severity = InfoBarSeverity.info});

  @override
  void show(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: width * 0.9,
              height: height * 0.1,
              child: InfoBar(
                title: Text(title),
                content: Text(content),
                severity: severity,
                onClose: () => Navigator.pop(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
