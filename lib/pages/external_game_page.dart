import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_native_view/flutter_native_view.dart';
import 'package:win32/win32.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';

class ExternalGamePage extends StatefulWidget {
  ExternalGameModel gameModel;

  ExternalGamePage(this.gameModel, {Key? key}) : super(key: key);

  @override
  State<ExternalGamePage> createState() => _ExternalGamePageState();
}

class _ExternalGamePageState extends State<ExternalGamePage> {
  late final NativeViewController viewController;

  @override
  void initState() {
    super.initState();
    viewController = NativeViewController(
      handle: FindWindow(
        nullptr,
        "placeholder".toNativeUtf16(),
      ),
      hitTestBehavior: HitTestBehavior.translucent,
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NativeView(
          controller: viewController,
          width: double.infinity,
          height: double.infinity),
    );
  }
}
