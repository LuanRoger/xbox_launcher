import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_windows/webview_windows.dart';

WebviewController useWebviewController() {
  return use(_WebviewControllerHook());
}

class _WebviewControllerHook extends Hook<WebviewController> {
  @override
  HookState<WebviewController, _WebviewControllerHook> createState() =>
      _WebviewControllerHookState();
}

class _WebviewControllerHookState
    extends HookState<WebviewController, _WebviewControllerHook> {
  late WebviewController webviewController;

  @override
  void initHook() {
    super.initHook();
    webviewController = WebviewController();
  }

  @override
  void dispose() {
    super.dispose();
    webviewController.dispose();
  }

  @override
  WebviewController build(BuildContext context) {
    return webviewController;
  }
}
