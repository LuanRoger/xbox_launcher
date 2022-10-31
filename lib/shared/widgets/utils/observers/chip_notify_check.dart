import 'package:xbox_launcher/shared/widgets/utils/observers/observer.dart';
import 'package:xbox_launcher/shared/widgets/utils/observers/observer_notifier.dart';

abstract class ChipNotifyCheck implements ObserverNotifier {
  late Observer observer;
  @override
  void notifyObserver();
}
