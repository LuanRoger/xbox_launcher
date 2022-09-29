import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/providers/focus_element_provider.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';
import 'package:xbox_launcher/routes/app_route_driver.dart';
import 'package:xbox_launcher/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  XInputController xInputController = XInputController();
  xInputController.init();

  ProfileProvider profileProvider = ProfileProvider();
  await profileProvider.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProfileProvider>(
      create: (_) => profileProvider,
    ),
    ChangeNotifierProvider<FocusElementProvider>(
        create: (_) => FocusElementProvider(null)),
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
            initialRoute: AppRoutes.homePageRoute,
            onGenerateRoute: AppRouteDriver.goToRoutes,
            theme: ThemeData(
                brightness: value.brightness,
                fontFamily: value.fontFamily,
                focusTheme: value.focusThemeData));
      }),
    );
  }
}
