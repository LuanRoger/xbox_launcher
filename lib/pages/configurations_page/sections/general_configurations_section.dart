import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xbox_launcher/pages/personalization_configuration_page.dart';

class GenralConfigurationSection extends ConfigurationSection {
  const GenralConfigurationSection({Key? key}) : super("General", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Personalizations",
                  icon: FluentIcons.personalize,
                  onPressed: () {
                    Navigator.push(
                        context,
                        FluentPageRoute(
                            builder: (context) =>
                                PersonalizationConfigurationPage(context)));
                  },
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Account",
                  icon: FluentIcons.accounts,
                  onPressed: () {},
                  height: 75,
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
                child: SystemButton(
                  "Contributors",
                  icon: FluentIcons.group,
                  onPressed: () {},
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "License",
                  icon: FluentIcons.entitlement_policy,
                  onPressed: () {},
                  height: 75,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
