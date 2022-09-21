import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';

abstract class ChipNotifyObserver {
  void notificationReact(ChipBase sender, Object? payload);
}
