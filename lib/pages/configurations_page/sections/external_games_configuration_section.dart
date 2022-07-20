import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/external_game_model.dart';
import 'package:xbox_launcher/pages/add_external_game_page.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';

class ExternalGamesConfigurationSection extends ConfigurationSection {
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
  Widget virtualBuild(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Flexible(
        child: TextButton(
          title: "Add external game",
          onPressed: () => Navigator.push(
              context, FluentPageRoute(builder: (_) => AddExternalGamePage())),
        ),
      ),
      Expanded(
        child: Consumer<ProfileProvider>(
          builder: (_, value, __) => ListView.separated(
              itemCount: value.externalGames.length,
              itemBuilder: (_, index) {
                ExternalGameModel externalGame =
                    value.externalGames[index] as ExternalGameModel;
                return ListTile(
                  title: Text(externalGame.name!),
                  subtitle: Text(externalGame.path),
                  trailing: IconButton(
                    icon: const Icon(FluentIcons.delete),
                    onPressed: () =>
                        deleteConfirmation(context, externalGame.name!, index),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider()),
        ),
      )
    ]);
  }
}
