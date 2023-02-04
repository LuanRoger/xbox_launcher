import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

class ElementFocusScope {
  final List<ElementFocusNode> _elementsFocusNode = List.empty(growable: true);
  void Function(FocableElement sender, Object? focusedElementValue)?
      onElementFocus;

  ElementFocusNode createFocusNode() {
    ElementFocusNode focusNode = ElementFocusNode(this);
    _elementsFocusNode.add(focusNode);

    return focusNode;
  }

  void dispose() {
    for (ElementFocusNode node in _elementsFocusNode) {
      node.dispose();
    }
  }
}
