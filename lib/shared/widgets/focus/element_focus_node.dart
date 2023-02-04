import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

class ElementFocusNode extends FocusNode {
  final ElementFocusScope _currentScope;
  late FocableElement _focableElement;

  ElementFocusNode(this._currentScope) {
    addListener(() => notifyFocus());
  }

  void setFocucableElement(FocableElement focableElement) {
    _focableElement = focableElement;
  }

  void notifyFocus() {
    _currentScope.onElementFocus
        ?.call(_focableElement, _focableElement.elementValue);
  }

  @override
    void dispose() {
      super.dispose();
      
    }
}
