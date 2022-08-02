import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/pages/add_external_game_page.dart';
import 'package:xbox_launcher/pages/add_profile_page.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';
import 'package:xbox_launcher/pages/external_game_page.dart';
import 'package:xbox_launcher/pages/game_page.dart';
import 'package:xbox_launcher/pages/home_page.dart';
import 'package:xbox_launcher/pages/manage_profile_page.dart';
import 'package:xbox_launcher/pages/my_library_page/my_library_page.dart';
import 'package:xbox_launcher/pages/personalization_configuration_page.dart';
import 'package:xbox_launcher/pages/profile_selector/profile_selector.dart';
import 'package:xbox_launcher/pages/video_configuration_page.dart';
import 'package:xbox_launcher/routes/app_routes.dart';

class AppRouteDriver {
  static Route<dynamic> goToRoutes(RouteSettings settings) {
    final List<dynamic>? routeArgs =
        settings.arguments != null ? settings.arguments as List<dynamic> : null;

    switch (settings.name) {
      case AppRoutes.homePageRoute:
        return homePageRoute;
      case AppRoutes.configurationRoute:
        return configurationPageRoute;
      case AppRoutes.myLibraryRoute:
        return myLibraryPageRoute;
      case AppRoutes.personalizationConfigRoute:
        return personalizationConfigPageRoute;
      case AppRoutes.videoConfigRoute:
        return videoConfigPageRoute;
      case AppRoutes.addExternalGameRoute:
        return addExternalGamePageRoute;
      case AppRoutes.addProfileRoute:
        return addProfilePageRoute;
      case AppRoutes.manageProfileRoute:
        return manageProfilePageRoute;
      case AppRoutes.selectProfileRoute:
        return getSelectProfilePageRoute(routeArgs![0] as String?,
            routeArgs[1] as void Function(BuildContext, ProfileModel));
      case AppRoutes.xcloudGameRoute:
        return getXcloudGamePageRoute(
            routeArgs![0] as GameModel, routeArgs[1] as String);
      case AppRoutes.externalGameRoute:
        return getExternalGamePageRoute(routeArgs![0] as ExternalGameModel);
      case AppRoutes.systemAppRoute:
        return getSystemAppPageRoute(routeArgs![0] as Widget);
      default:
        return homePageRoute;
    }
  }

  static FluentPageRoute get homePageRoute =>
      FluentPageRoute(builder: (_) => HomePage());
  static FluentPageRoute get configurationPageRoute =>
      FluentPageRoute(builder: (_) => ConfigurationsPage());
  static FluentPageRoute get myLibraryPageRoute =>
      FluentPageRoute(builder: (_) => MyLibraryPage());
  static FluentPageRoute get personalizationConfigPageRoute =>
      FluentPageRoute(builder: (_) => PersonalizationConfigurationPage());
  static FluentPageRoute get videoConfigPageRoute =>
      FluentPageRoute(builder: (_) => VideoConfigurationPage());
  static FluentPageRoute get addExternalGamePageRoute =>
      FluentPageRoute(builder: (_) => AddExternalGamePage());
  static FluentPageRoute get addProfilePageRoute =>
      FluentPageRoute(builder: (_) => AddProfilePage());
  static FluentPageRoute get manageProfilePageRoute =>
      FluentPageRoute(builder: (_) => ManageProfilePage());
  static FluentPageRoute getSelectProfilePageRoute(
          String? title, void Function(BuildContext, ProfileModel) callback) =>
      FluentPageRoute(
        builder: (_) =>
            ProfileSelector(title: title, onProfileSelect: callback),
      );
  static FluentPageRoute getXcloudGamePageRoute(
          GameModel gameModel, String server) =>
      FluentPageRoute(
          builder: (_) => GamePage(
                gameModel,
                server: server,
              ));
  static FluentPageRoute getExternalGamePageRoute(
          ExternalGameModel gameModel) =>
      FluentPageRoute(builder: (_) => ExternalGamePage(gameModel));
  static FluentPageRoute getSystemAppPageRoute(Widget appHomePage) =>
      FluentPageRoute(builder: (_) => appHomePage);
}
