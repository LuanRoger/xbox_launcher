import 'package:fluent_ui/fluent_ui.dart';
import 'package:webview_windows/webview_windows.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GamePage extends StatefulWidget {
  String gameUrl;
  ImageProvider gameCover;

  GamePage(this.gameUrl, this.gameCover, {Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final _controller = WebviewController();
  late bool _loadReady;
  bool _entranceAnimationDone = true;

  @override
  void initState() {
    super.initState();
    _loadReady = false;
    initPlatformState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    await _controller.initialize();
    _controller.url.listen((url) {
      print(url);
      if (url == "https://www.xbox.com/en-US/play") {
        Navigator.pop(context);
      }
    });

    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await _controller.loadUrl(widget.gameUrl);
    _controller.loadingState.listen((event) {
      if (event == LoadingState.navigationCompleted) {
        setState(() {
          _loadReady = true;
        });
      }
    });

    if (!mounted) return;
    setState(() {});
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => ContentDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
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
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Stack(
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
                          setState(() {
                            _entranceAnimationDone = false;
                          });
                        },
                        child: Center(
                            child: Image(
                          image: widget.gameCover,
                          fit: BoxFit.cover,
                        ))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
