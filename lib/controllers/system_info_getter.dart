import 'package:sys_info_getter/sys_info_getter.dart';

class SystemInfoGetter {
  final TerminalHelper _terminalHelper = TerminalHelper(PowershellProvider());

  Future<SystemInformations> _updateInfos() async =>
      await _terminalHelper.update();

  Future<List<DiskInfo>?> getDisksInfos() async =>
      (await _updateInfos()).diskInfo;
}
