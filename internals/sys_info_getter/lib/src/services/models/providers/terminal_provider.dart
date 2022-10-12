import 'package:sys_info_getter/src/services/models/terminal_interface.dart';

abstract class TerminalProvider {
  final TerminalInterface interface;

  TerminalProvider(this.interface);
}
