import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class XboxProgressRing extends StatelessWidget {
  double? value;
  bool backwards;
  double strokeWidth;

  XboxProgressRing(
      {super.key, this.value, this.backwards = false, this.strokeWidth = 4.5});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) => ProgressRing(
        value: this.value,
        activeColor: value.accentColor,
        backwards: backwards,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
