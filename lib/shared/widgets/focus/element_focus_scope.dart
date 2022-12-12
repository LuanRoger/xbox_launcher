import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

typedef OnElementFocusCallback = void Function(
    FocableElement sender, Object? focusedElementValue);

class ElementFocusScope {
  final List<OnElementFocusCallback?> _focusCallbacks =
      List.empty(growable: true);

  void setCallback(OnElementFocusCallback callback) {
    _focusCallbacks.add(callback);
  }

  void removeCallback(OnElementFocusCallback callback) {
    _focusCallbacks.remove(callback);
  }

  void reciveFocusNotification(
      FocableElement sender, Object? focusedElementValue) {
    for (OnElementFocusCallback? callback in _focusCallbacks) {
      callback?.call(sender, focusedElementValue);
    }
  }
}
