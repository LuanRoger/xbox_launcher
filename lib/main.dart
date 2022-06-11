import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xbox_launcher/controllers/apps_historic.dart';
import 'package:xbox_launcher/pages/home_page.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(center: true);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    //await windowManager.setFullScreen(true);
  });

  XInputController xInputController = XInputController();
  xInputController.init();

  ProfileProvider profileProvider = ProfileProvider();
  await profileProvider.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => profileProvider,
    ),
  ], child: const FlutterAppMain()));
}

class FlutterAppMain extends StatelessWidget {
  const FlutterAppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: ((_, value, __) {
        return FluentApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: value.brightness,
                fontFamily: value.fontFamily,
                focusTheme: value.focusThemeData),
            home: HomePage());
      }),
    );
  }
}
