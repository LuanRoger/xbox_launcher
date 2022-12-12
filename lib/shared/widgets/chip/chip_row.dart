// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:xbox_launcher/shared/widgets/utils/observers/observer.dart';

class ChipsRow extends StatelessWidget implements Observer {
  final List<ChipBase> chips;
  final void Function(bool, List<Object?>) onCheckChange;

  ChipsRow(this.chips, {super.key, required this.onCheckChange}) {
    _injectObserver();
  }

  void _injectObserver() {
    for (var chip in chips) chip.observer = this;
  }

  @override
  void react(Object sender, Object? payload) {
    List<Object?> currentsSelected =
        chips.where((chip) => chip.isSelected).map((e) => e.value).toList();

    onCheckChange((sender as ChipBase).isSelected, currentsSelected);
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
