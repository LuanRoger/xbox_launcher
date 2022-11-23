import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';

class XboxProgressRing extends ConsumerWidget {
  double? value;
  bool backwards;
  double strokeWidth;

  XboxProgressRing(
      {super.key, this.value, this.backwards = false, this.strokeWidth = 4.5});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(profileThemeProvider);

    return ProgressRing(
      value: value,
      activeColor: theme.accentColor,
      backwards: backwards,
      strokeWidth: strokeWidth,
    );
  }
}
