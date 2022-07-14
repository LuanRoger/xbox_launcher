import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_native_view/flutter_native_view.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/pages/home_page.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterNativeView.ensureInitialized();
  await windowManager.ensureInitialized();

  XInputController xInputController = XInputController();
  xInputController.init();

  ProfileProvider profileProvider = ProfileProvider();
  await profileProvider.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => profileProvider,
    ),
    Provider<ControllerActionProvider>(
        create: (_) => ControllerActionProvider(xInputController)),
    Provider(create: (_) => KeyboardActionProvider())
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
