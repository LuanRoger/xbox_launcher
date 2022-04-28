import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/pages/home_page/home_page.dart';
import 'package:xbox_launcher/shared/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(center: true);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    //await windowManager.setFullScreen(true);
  });

  runApp(MultiProvider(
    providers: [
      Provider<XinputController>(
        create: (_) => XinputController(),
      )
    ],
    child: FluentApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.defaultTheme,
        home: HomePage()),
  ));
}
