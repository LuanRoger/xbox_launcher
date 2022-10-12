import 'package:sys_info_getter/sys_info_getter.dart';

void main() async {
  TerminalHelper terminalHelper = TerminalHelper(PowershellProvider());
  SystemInformations informations = await terminalHelper.update();
}
