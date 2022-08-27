import 'package:fluent_ui/fluent_ui.dart' hide TextButton, IconButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/external_game_icon.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';

class ExternalGamesConfigurationSection extends NavigationSection {
  const ExternalGamesConfigurationSection({Key? key})
      : super("External games", key: key);

  Future deleteConfirmation(
      BuildContext context, String gameName, int gameIndex) async {
    await SystemDialog(
        title: "Delete external game?",
        content: "Do you want to delete $gameName from your external games?",
        actions: [
          TextButton(
              title: "Confirm",
              onPressed: () {
                Provider.of<ProfileProvider>(context, listen: false)
                    .removeExternalGame(gameIndex);
                Navigator.pop(context);
              }),
          TextButton(title: "Cancel", onPressed: () => Navigator.pop(context))
        ]).show(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: FluentIcons.add,
          width: 100.0,
          height: 30.0,
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.addExternalGameRoute),
        ),
      ];

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Expanded(
          flex: 10,
          child: Consumer<ProfileProvider>(
            builder: (_, value, __) => ListView.separated(
                itemCount: value.externalGames.length,
                itemBuilder: (_, index) {
                  ExternalGameModel externalGame = value.externalGames[index];
                  return ListTile(
                    title: Text(externalGame.name),
                    subtitle: Text(externalGame.path),
                    leading: ExternalGameIcon(
                      iconUrl: externalGame.iconUrl,
                    ),
                    trailing: IconButton(
                      icon: FluentIcons.delete,
                      onPressed: () =>
                          deleteConfirmation(context, externalGame.name, index),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider()),
          ),
        )
      ];
}
