import 'dart:io';

import 'package:sys_info_getter/src/services/models/terminal_interface.dart';

class PowershellService implements TerminalInterface {
  @override
  Future<String> executeCommand(String command) async {
    final powershell =
        await Process.run("Powershell.exe", [command], runInShell: true);
    return powershell.exitCode == 0 ? powershell.stdout : "";
  }
}
