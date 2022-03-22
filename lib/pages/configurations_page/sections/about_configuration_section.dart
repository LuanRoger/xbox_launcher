import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class AboutConfigurationSection extends ConfigurationSection {
  const AboutConfigurationSection({Key? key}) : super("About", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Xbox Launcher v0.0.1",
              style: AppTextStyle.ABOUT_SECTION_TITLE_CONFIGURATION,
            ),
          ],
        ),
        Text(
          "Created by: " + "Luan Roger c 2022",
          style: AppTextStyle.ABOUT_SECTION_TEXT,
        )
      ],
    );
  }
}
