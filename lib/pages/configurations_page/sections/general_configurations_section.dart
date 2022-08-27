import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';

class GenralConfigurationSection extends NavigationSection {
  const GenralConfigurationSection({Key? key}) : super("General", key: key);

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Flexible(
            flex: 15,
            child: ButtonGrid(buttons: {
              null: [
                IconTextButton(
                  title: "Personalizations",
                  icon: FluentIcons.personalize,
                  width: null,
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppRoutes.personalizationConfigRoute);
                  },
                ),
                IconTextButton(
                  title: "Contributors",
                  icon: FluentIcons.group,
                  width: null,
                  onPressed: () {},
                ),
              ],
              "": [
                IconTextButton(
                  title: "Video",
                  icon: FluentIcons.t_v_monitor,
                  width: null,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.videoConfigRoute),
                ),
                IconTextButton(
                  title: "License",
                  icon: FluentIcons.entitlement_policy,
                  width: null,
                  onPressed: () {},
                ),
              ]
            }))
      ];
}
