import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:sys_info_getter/sys_info_getter.dart';
import 'package:xbox_launcher/controllers/system_info_getter.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/hooks/element_focus_node_hook.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/volume_info/volume_info_list.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class ManageSection extends NavigationSectionStateless {
  const ManageSection({super.key, super.currentScope}) : super("Manage");

  Future<List<DiskInfo>?> getDiskInfos() {
    SystemInfoGetter infoGetter = SystemInfoGetter();
    return infoGetter.getDisksInfos();
  }

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tiles", style: AppTextStyle.MY_APPS_SECTIONS_TILE),
            IconTextButton(
                title: "Tile size",
                icon: FluentIcons.size_legacy,
                focusNode: useElementFocusNode(currentScope!),
                onPressed: () {
                  ContextMenu("Tiles sizes", contextItems: [
                    ContextMenuItem("Small", onPressed: () {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .myLibraryTileSize = TileSize.SMALL;
                      Navigator.pop(context);
                    }),
                    ContextMenuItem("Medium", onPressed: () {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .myLibraryTileSize = TileSize.MEDIUM;
                      Navigator.pop(context);
                    }),
                    ContextMenuItem("Big", onPressed: () {
                      Provider.of<ProfileProvider>(context, listen: false)
                          .myLibraryTileSize = TileSize.BIG;
                      Navigator.pop(context);
                    })
                  ]).show(context);
                })
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Device info",
                style: AppTextStyle.MY_APPS_SECTIONS_TILE),
            FutureBuilder<List<DiskInfo>?>(
              future: getDiskInfos(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const ProgressRing();
                  default:
                    return Expanded(
                        child: VolumeInfoList(diskInfos: snapshot.data!));
                }
              },
            )
          ],
        ),
      ),
    ];
  }
}
