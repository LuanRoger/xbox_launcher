import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/home_page/home_page.dart';

void main() {
  runApp(FluentApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, focusTheme: const FocusThemeData(glowFactor: 4.0)),
      home: const HomePage()));
}
