import 'package:clock/clock.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class ClockTimer extends StatefulWidget {
  final TextStyle? textStyle;

  const ClockTimer({Key? key, this.textStyle}) : super(key: key);

  @override
  State<ClockTimer> createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  late Clock clock;
  late DateTime timeNow;

  @override
  void initState() {
    super.initState();

    clock = const Clock();
    timeNow = clock.now();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(minutes: 1), () {
      if (mounted) {
        setState(() => timeNow = clock.now());
      }
    });

    return Text(
      "${timeNow.hour}:${timeNow.minute < 10 ? "0${timeNow.minute}" : timeNow.minute}",
      style: widget.textStyle ?? AppTextStyle.CLOCK_TEXT,
    );
  }
}
