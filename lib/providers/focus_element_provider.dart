import 'package:fluent_ui/fluent_ui.dart';

class FocusElementProvider extends ValueNotifier {
  Object? _currentValue;
  Object? get currentValue => _currentValue;
  Object? _sender;
  Object? get sender => _sender;

  FocusElementProvider(this._currentValue) : super(_currentValue);

  void setCurrentValue(Object sender, Object value) {
    _sender = sender;
    _currentValue = value;

    notifyListeners();
  }

  void clear() {
    _currentValue = null;
    _sender = null;

    notifyListeners();
  }
}
