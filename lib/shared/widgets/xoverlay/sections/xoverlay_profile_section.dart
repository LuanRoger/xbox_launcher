import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_info.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/widgets/xoverlay_section_base.dart';

class XOverlayProfileSection extends XOverlaySectionBase {
  XOverlayProfileSection({Key? key}) : super(key: key, sectionTitle: "Profile");

  @override
  Widget virtualBuild(BuildContext context) {
    return ListView(
      children: [
        SystemOutlinedButton(
            content: ProfileInfo(
              radiusSize: 20,
            ),
            onPressed: () {})
      ],
    );
  }
}
