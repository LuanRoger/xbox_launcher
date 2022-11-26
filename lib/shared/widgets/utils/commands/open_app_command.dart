import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/shared_command.dart';

class OpenAppCommand implements SharedCommand {
  AppModel appModel;
  BuildContext context;

  OpenAppCommand(this.appModel, {required this.context});

  @override
  void execute() {
    switch (appModel.appType) {
      case AppType.GAME:
        goToGameApp();
        break;
      case AppType.SYSTEM_APP:
        goToSystemApp();
        break;
    }
  }

  void goToSystemApp() {
    Navigator.pushNamed(context, AppRoutes.systemAppRoute,
        arguments: [(appModel as SystemAppModel).appHome!]);

    context.read<ProfileProvider>().addAppToHistory(appModel);
  }

  void goToGameApp() {
    final profileInfo = context.read<ProfileProvider>();

    Navigator.pushNamed(context, AppRoutes.xcloudGameRoute,
        arguments: [appModel, profileInfo.preferedServer]);
    profileInfo.addAppToHistory(appModel);
  }
}
