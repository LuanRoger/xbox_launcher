import 'package:fluent_ui/fluent_ui.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/utils/string_formatter.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GamePage extends StatefulWidget {
  String gameUrl;
  ImageProvider gameCover;
  String server;

  GamePage(this.gameUrl, this.gameCover, {Key? key, required this.server})
      : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controller = WebviewController();
  late String xcloudBaseUrl;
  late String gameUrl;

  late bool _loadReady;
  bool _entranceAnimationDone = true;

  void formatUrlToServer() {
    xcloudBaseUrl =
        StringFormatter.format(AppConsts.XCLOUD_PLAY_BASE_URL, [widget.server]);
    gameUrl = StringFormatter.format(widget.gameUrl, [widget.server]);
  }

  @override
  void initState() {
    _loadReady = false;
    formatUrlToServer();
    initPlatformState();

    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();

    super.dispose();
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
    _controller.loadingState.listen((event) {
      if (event == LoadingState.navigationCompleted) {
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
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Webview(
          _controller,
          permissionRequested: _onPermissionRequested,
        ),
        Visibility(
          visible: _entranceAnimationDone,
          child: AnimatedOpacity(
              opacity: _loadReady ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              onEnd: () {
                setState(() => _entranceAnimationDone = false);
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: widget.gameCover,
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }
}
