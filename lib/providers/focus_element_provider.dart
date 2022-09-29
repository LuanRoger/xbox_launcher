import 'package:fluent_ui/fluent_ui.dart';

class FocusElementProvider extends ValueNotifier {
  Object? _currentValue;
  Object? get currentValue => _currentValue;
  set currentValue(Object? value) {
    _currentValue = value;

    notifyListeners();
  }

  FocusElementProvider(this._currentValue) : super(_currentValue);

  void clear() {
    _currentValue = null;
  }
}
