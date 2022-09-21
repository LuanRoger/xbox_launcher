import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_notify_check.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_notify_observer.dart';

abstract class ChipBase extends StatelessWidget implements ChipNotifyCheck {
  bool isSelected;
  Object? value;
  void Function(bool, Object?)? onCheck;
  double? height;
  double? width;

  @override
  late ChipNotifyObserver singleObserver;
  @override
  void notifyObserver() => singleObserver.notificationReact(this, value);

  Widget buttonChipChild(BuildContext context);

  ChipBase(
      {Key? key,
      required this.isSelected,
      this.onCheck,
      this.value,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Button(
          child: buttonChipChild(context),
          onPressed: () {
            isSelected = !isSelected;
            onCheck?.call(isSelected, value);
          },
          style: ButtonStyle(
              padding: ButtonState.all(const EdgeInsets.all(15.0)),
              backgroundColor: isSelected
                  ? ButtonState.all(context.read<ProfileProvider>().accentColor)
                  : ButtonState.all(Colors.transparent),
              shadowColor:
                  !isSelected ? ButtonState.all(Colors.transparent) : null,
              border: ButtonState.all(BorderSide.none)),
        ),
      ),
    );
  }
}
