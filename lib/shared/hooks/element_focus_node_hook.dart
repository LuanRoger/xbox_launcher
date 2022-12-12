import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';

ElementFocusNode useElementFocusNode(ElementFocusScope currentScope) {
  return use(_ElementFocusNodeHook(currentScope));
}

class _ElementFocusNodeHook extends Hook<ElementFocusNode> {
  final ElementFocusScope elementFocusScope;

  const _ElementFocusNodeHook(this.elementFocusScope);

  @override
  HookState<ElementFocusNode, _ElementFocusNodeHook> createState() =>
      _ElementFocusNodeState();
}

class _ElementFocusNodeState
    extends HookState<ElementFocusNode, _ElementFocusNodeHook> {
  late ElementFocusNode elementFocusNode;

  @override
  void initHook() {
    super.initHook();
    elementFocusNode = ElementFocusNode(hook.elementFocusScope);
  }

  @override
  void dispose() {
    super.dispose();
    elementFocusNode.dispose();
  }

  @override
  ElementFocusNode build(BuildContext context) => elementFocusNode;
}
