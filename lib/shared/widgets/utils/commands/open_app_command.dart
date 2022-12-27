import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/command.dart';

class OpenAppCommand implements Command {
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
    SystemAppModel systemAppModel = appModel as SystemAppModel;
    Navigator.pushNamed(context, AppRoutes.systemAppRoute,
        arguments: [systemAppModel.appHome!]);
    Provider.of<ProfileProvider>(context, listen: false)
        .addAppToHistory(appModel);
  }

  void goToGameApp() {
    GameModel gameModel = appModel as GameModel;
    Navigator.pushNamed(context, AppRoutes.xcloudGameRoute,
        arguments: [gameModel, context.read<ProfileProvider>().preferedServer]);
    Provider.of<ProfileProvider>(context, listen: false)
        .addAppToHistory(gameModel);
  }
}
