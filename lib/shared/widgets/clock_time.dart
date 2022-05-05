import 'package:clock/clock.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({Key? key}) : super(key: key);

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
      setState(() => timeNow = clock.now());
    });

    return Text(
      "${timeNow.hour}:${timeNow.minute < 10 ? "0${timeNow.minute}" : timeNow.minute}",
      style: AppTextStyle.CLOCK_TEXT,
    );
  }
}
