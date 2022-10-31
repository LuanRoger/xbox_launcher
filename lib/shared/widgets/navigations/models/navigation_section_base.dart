import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';

abstract class NavigationSectionBase {
  final String sectionName;
  final ElementFocusScope? currentScope;

  NavigationSectionBase(this.sectionName, {this.currentScope});
}
