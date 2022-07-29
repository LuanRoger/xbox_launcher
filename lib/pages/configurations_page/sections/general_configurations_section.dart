import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/video_configuration_page.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/pages/personalization_configuration_page.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';

class GenralConfigurationSection extends NavigationSection {
  GenralConfigurationSection({Key? key}) : super("General", key: key);

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "Personalizations",
                  icon: FluentIcons.personalize,
                  onPressed: () {
                    Navigator.push(
                        context,
                        FluentPageRoute(
                            builder: (context) =>
                                PersonalizationConfigurationPage()));
                  },
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "Video",
                  icon: FluentIcons.t_v_monitor,
                  onPressed: () => Navigator.push(
                      context,
                      FluentPageRoute(
                          builder: (context) => VideoConfigurationPage())),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 25,
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "Contributors",
                  icon: FluentIcons.group,
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "License",
                  icon: FluentIcons.entitlement_policy,
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ];
}
