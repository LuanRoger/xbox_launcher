import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/pages/home_page/home_page.dart';
import 'package:xbox_launcher/shared/app_theme_data.dart';

void main() {
  XinputController xinputController = XinputController();
  xinputController.init();

  runApp(FluentApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.defaultTheme,
      home: const HomePage()));
}
