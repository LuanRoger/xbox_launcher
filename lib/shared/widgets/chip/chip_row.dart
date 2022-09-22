import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_notify_observer.dart';
import 'package:collection/collection.dart';

class ChipsRow extends StatefulWidget {
  final List<ChipBase> chips;
  final void Function(bool, Object?) onCheckChange;

  const ChipsRow(this.chips, {Key? key, required this.onCheckChange})
      : super(key: key);

  @override
  State<ChipsRow> createState() => _ChipsRowState();
}

class _ChipsRowState extends State<ChipsRow> implements ChipNotifyObserver {
  late List<ChipBase> chips;

  @override
  void initState() {
    super.initState();
    chips = List.from(widget.chips);
    // ignore: avoid_function_literals_in_foreach_calls
    chips.forEach((chip) {
      chip.observer = this;
      chip.onCheck = widget.onCheckChange;
    });
  }

  @override
  void notificationReact(ChipBase sender, Object? payload) {
    ChipBase? currentSelected =
        chips.firstWhereOrNull((chip) => chip != sender && chip.isSelected);
    currentSelected?.rebuildChip(() {
      currentSelected.isSelected = false;
    });
    widget.onCheckChange(sender.isSelected, payload);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: chips,
    );
  }
}
