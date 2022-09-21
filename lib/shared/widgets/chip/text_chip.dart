import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';

class TextChip extends ChipBase {
  final String text;

  TextChip(this.text,
      {Key? key,
      bool isSelected = false,
      double? height,
      double? width,
      void Function(bool, Object?)? onCheck})
      : super(
            key: key,
            isSelected: isSelected,
            value: text,
            height: height,
            width: width,
            onCheck: onCheck);

  @override
  Widget buttonChipChild(BuildContext context) => Text(text);
}
