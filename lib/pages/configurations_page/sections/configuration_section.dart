import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class ConfigurationSection extends StatelessWidget {
  final String title;

  const ConfigurationSection(this.title, {Key? key}) : super(key: key);

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 250, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Text(
              title,
              style: AppTextStyle.CONFIGURATION_TITLE,
            ),
          ),
          const Spacer(),
          Expanded(flex: 10, child: virtualBuild(context))
        ],
      ),
    );
  }
}
