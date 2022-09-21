import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_notify_observer.dart';

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
    // ignore: avoid_function_literals_in_foreach_calls
    chips = List.from(widget.chips);
    chips.forEach((chip) {
      chip.singleObserver = this;
      if (widget.onCheckChange != null) {
        chip.onCheck = widget.onCheckChange;
      }
    });
  }

  @override
  void notificationReact(Object sender, Object? payload) {
    ChipBase checkedChip =
        chips.firstWhere((chip) => chip == sender as ChipBase);
    widget.onCheckChange(checkedChip.isSelected, payload);
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
