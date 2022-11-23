import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';

void useOnFocusedElement(
    ElementFocusScope focusScope, OnElementFocusCallback focusCallback) {
  return use(_FocusScopeHook(focusScope, focusCallback));
}

class _FocusScopeHook extends Hook<void> {
  final ElementFocusScope focusScope;
  final OnElementFocusCallback focusCallback;

  const _FocusScopeHook(this.focusScope, this.focusCallback);

  @override
  HookState<void, _FocusScopeHook> createState() => _FocusScopeHookState();
}

class _FocusScopeHookState extends HookState<void, _FocusScopeHook> {
  @override
  void initHook() {
    super.initHook();
    hook.focusScope.setCallback(hook.focusCallback);
  }

  @override
  void dispose() {
    super.dispose();
    hook.focusScope.removeCallback(hook.focusCallback);
  }

  @override
  void build(BuildContext context) {}
}
