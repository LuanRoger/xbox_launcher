import 'package:xbox_launcher/shared/widgets/chip/chip_notify_observer.dart';

abstract class ChipNotifyCheck {
  late ChipNotifyObserver singleObserver;
  void notifyObserver();
}
