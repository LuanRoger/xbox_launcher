import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

class ElementFocusNode extends FocusNode {
  final ElementFocusScope _currentScope;
  late final FocableElement _focableElement;

  ElementFocusNode(this._currentScope) {
    addListener(notifyFocus);
  }

  void notifyFocus() {
    _currentScope.reciveFocusNotification(
        _focableElement, _focableElement.elementValue);
  }

  void setCurrentElement(FocableElement element) {
    _focableElement = element;
  }
}
