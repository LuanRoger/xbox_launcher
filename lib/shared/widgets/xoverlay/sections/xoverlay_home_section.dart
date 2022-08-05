import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/list/app_list_item.dart';
import 'package:xbox_launcher/shared/widgets/list/apps_list.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/widgets/xoverlay_section_base.dart';

class XOverlayHomeSection extends XOverlaySectionBase {
  XOverlayHomeSection({Key? key}) : super(key: key, sectionTitle: "Home");

  @override
  Widget virtualBuild(BuildContext context) {
    return ListView(
      children: [
        Flexible(
          flex: 0,
          child: IconOutlinedButton(
            icon: const Icon(FluentIcons.home, size: 20),
            text: "Home",
            onPressed: () =>
                Navigator.popAndPushNamed(context, AppRoutes.homePageRoute),
          ),
        ),
        Flexible(
          flex: 0,
          child: IconOutlinedButton(
            icon: const Icon(
              FluentIcons.library,
              size: 20,
            ),
            text: "My library",
            onPressed: () =>
                Navigator.popAndPushNamed(context, AppRoutes.myLibraryRoute),
          ),
        ),
        const Flexible(child: Divider()),
        Expanded(
            flex: 0,
            child: AppsList(
              shrinkWrap: true,
              scrollPhysics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                List<AppModel> apps = context.read<ProfileProvider>().lastApps;

                AppModel currentApp = apps[index];
                CommandInvoker command = CommandInvoker(
                    OpenAppCommand(currentApp, context: context));

                return AppListItem(currentApp, onPressed: () {
                  Navigator.pop(context);
                  command.execute();
                });
              },
              itemCount: 4,
            ))
      ],
    );
  }
}
