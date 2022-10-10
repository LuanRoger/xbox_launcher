import 'package:fluent_ui/fluent_ui.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/utils/string_formatter.dart';

class GamePage extends XboxPageStateful {
  final GameModel gameModel;
  final String server;
  final bool autoLogin;
  final bool autoPlay;

  const GamePage(this.gameModel,
      {Key? key,
      required this.server,
      this.autoLogin = true,
      this.autoPlay = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends XboxPageState<GamePage> {
  final _controller = WebviewController();
  final navigatorKey = GlobalKey<NavigatorState>();
  late final FocusNode webViewFocus;
  late final String xcloudBaseUrl;
  late final String gameUrl;

  late bool _loadReady;
  late bool _autoLogin;
  late bool _autoPlay;
  bool _entranceAnimationDone = true;

  void formatUrlToServer() {
    xcloudBaseUrl =
        StringFormatter.format(AppConsts.XCLOUD_PLAY_BASE_URL, [widget.server]);
    gameUrl =
        StringFormatter.format(widget.gameModel.xcloudUrl, [widget.server]);
  }

  @override
  void initState() {
    super.initState();

    _autoLogin = widget.autoLogin;
    _autoPlay = widget.autoPlay;
    _loadReady = false;

    webViewFocus = FocusNode();
    formatUrlToServer();
    initPlatformState();
  }

  @override
  dispose() {
    _controller.dispose();
    webViewFocus.dispose();

    super.dispose();
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => null;

  Future autoLogin() async {
    await _controller.executeScript(
        "document.getElementsByClassName(\"${AppConsts.LOGIN_BUTTON_CLASS_NAME}\")[0].click()");
  }

  Future autoPlay() async {
    await _controller.executeScript(
        "document.getElementsByClassName(\"${AppConsts.PLAY_GAME_BUTTON_CLASS_NAME}\")[0].focus()");
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    _controller.url.listen((url) {
      if (url == xcloudBaseUrl) {
        Navigator.pop(context);
      }
    });

    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await _controller.loadUrl(gameUrl);
    _controller.loadingState.listen((event) async {
      if (event != LoadingState.navigationCompleted) return;

      if (_autoLogin) {
        await autoLogin();
        _autoLogin = false;
      }
      if (_autoPlay) {
        await autoPlay();
        setState(() => _autoPlay = false);
      }
      if (!_loadReady && !_autoLogin && !_autoPlay) {
        setState(() => _loadReady = true);
      }
    });
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
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Focus(
          focusNode: webViewFocus,
          child: Webview(
            _controller,
            permissionRequested: _onPermissionRequested,
          ),
        ),
        Visibility(
          visible: _entranceAnimationDone,
          child: AnimatedOpacity(
              opacity: _loadReady ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              onEnd: () {
                setState(() => _entranceAnimationDone = false);
                webViewFocus.requestFocus();
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: NetworkImage(widget.gameModel.gameImageUrl),
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }
}
