import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class AboutConfigurationSection extends NavigationSectionStateless {
  const AboutConfigurationSection({Key? key}) : super("About", key: key);

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) => const [
        Flexible(
          flex: 5,
          child: Text(
            "Xbox Launcher v0.0.1",
            style: AppTextStyle.ABOUT_SECTION_TITLE_CONFIGURATION,
          ),
        ),
        Flexible(
          flex: 5,
          child: Text(
            "Created by: " "Luan Roger c 2022",
            style: AppTextStyle.ABOUT_SECTION_TEXT,
          ),
        )
      ];
}
