import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/external_game_model.dart';
import 'package:xbox_launcher/pages/add_external_game_page.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';

class ExternalGamesConfigurationSection extends ConfigurationSection {
  const ExternalGamesConfigurationSection({Key? key})
      : super("External games", key: key);

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
                );
              },
              separatorBuilder: (_, __) => const Divider()),
        ),
      )
    ]);
  }
}
