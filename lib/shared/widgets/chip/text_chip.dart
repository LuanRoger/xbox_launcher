import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';

class TextChip extends ChipBase {
  final String text;

  TextChip(this.text,
      {super.key,
      super.isSelected = false,
      super.height,
      super.width,
      super.value,
      super.focusNode});

  @override
  Widget buttonChipChild(BuildContext context) => Text(text);
}
