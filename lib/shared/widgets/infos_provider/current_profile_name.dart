import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class CurrentProfileName extends ConsumerWidget {
  final TextOverflow textOverflow;

  const CurrentProfileName({super.key, this.textOverflow = TextOverflow.fade});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(currentProfileProvider);

    return Text(
      profileProvider.name,
      overflow: textOverflow,
      style: AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
    );
  }
}
