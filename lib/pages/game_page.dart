// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/hooks/webview_controller_hook.dart';
import 'package:xbox_launcher/shared/widgets/xbox_page.dart';
import 'package:xbox_launcher/utils/string_formatter.dart';

class GamePage extends XboxPage {
  final GameModel gameModel;
  final String server;

  final navigatorKey = GlobalKey<NavigatorState>();
  late final String xcloudBaseUrl;
  late final String gameUrl;

  GamePage(this.gameModel, {super.key, required this.server});

  void formatUrlToServer() {
    xcloudBaseUrl =
        StringFormatter.format(AppConsts.XCLOUD_PLAY_BASE_URL, [server]);
    gameUrl = StringFormatter.format(gameModel.xcloudUrl, [server]);
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => null;

  //TODO: This will be implemented soon
  // Future autoLogin() async {
  //   await _controller.executeScript(
  //       "document.getElementsByClassName(\"${AppConsts.LOGIN_BUTTON_CLASS_NAME}\")[0].click()");
  // }

  // Future autoPlay() async {
  //   await _controller.executeScript(
  //       "document.getElementsByClassName(\"${AppConsts.PLAY_GAME_BUTTON_CLASS_NAME}\")[0].focus()");
  // }

  Future<void> initPlatformState(WebviewController controller) async {
    await controller.initialize();
    controller.url.listen((url) {
      if (url == xcloudBaseUrl) {
        Navigator.pop(useContext());
      }
    });

    await controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await controller.loadUrl(gameUrl);
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => ContentDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  Widget virtualBuild(BuildContext context) {
    final loadReadyState = useState(false);
    final entranceAnimationDoneState = useState(true);
    final webviewController = useWebviewController();

    formatUrlToServer();

    initPlatformState(webviewController);
    webviewController.loadingState.listen((event) async {
      if (event != LoadingState.navigationCompleted) return;

      if (!loadReadyState.value) loadReadyState.value = true;
    });

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Webview(
          webviewController,
          permissionRequested: _onPermissionRequested,
        ),
        Visibility(
          visible: entranceAnimationDoneState.value,
          child: AnimatedOpacity(
              opacity: loadReadyState.value ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              onEnd: () {
                entranceAnimationDoneState.value = false;
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: NetworkImage(gameModel.gameImageUrl),
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }
}
