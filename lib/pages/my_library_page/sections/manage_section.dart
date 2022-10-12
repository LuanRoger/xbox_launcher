import 'package:fluent_ui/fluent_ui.dart';
import 'package:sys_info_getter/sys_info_getter.dart';
import 'package:xbox_launcher/controllers/system_info_getter.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/volume_info/volume_info_list.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class ManageSection extends NavigationSectionStateless {
  const ManageSection({super.key}) : super("Manage");

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
        child: ButtonGrid(buttons: {
          "Tiles": [
            IconTextButton(
                title: "Tile size",
                icon: FluentIcons.size_legacy,
                onPressed: () {
                  ContextMenu("Tiles sizes", contextItems: [
                    ContextMenuItem("Small", onPressed: () {}),
                    ContextMenuItem("Medium", onPressed: () {}),
                    ContextMenuItem("Big", onPressed: () {})
                  ]).show(context);
                })
          ]
        }),
      ),
      const Text("Device info", style: AppTextStyle.MY_APPS_SECTIONS_TILE),
      Flexible(
          child: FutureBuilder<List<DiskInfo>?>(
        future: getDiskInfos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ProgressRing();
            default:
              return VolumeInfoList(diskInfos: snapshot.data!);
          }
        },
      )),
    ];
  }
}
