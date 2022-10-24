import 'package:sys_info_getter/src/services/models/providers/terminal_provider.dart';
import 'package:sys_info_getter/src/services/models/terminal_interface.dart';
import 'package:sys_info_getter/src/services/powershell_service.dart';

class PowershellProvider implements TerminalProvider {
  @override
  TerminalInterface get interface => PowershellService();
}
