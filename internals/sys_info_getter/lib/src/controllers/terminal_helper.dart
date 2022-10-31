import 'package:sys_info_getter/src/cmd_consts.dart';
import 'package:sys_info_getter/src/models/disk_info.dart';
import 'package:sys_info_getter/src/models/system_informations.dart';
import 'package:sys_info_getter/src/services/models/providers/terminal_provider.dart';
import 'package:sys_info_getter/src/services/models/terminal_interface.dart';
import 'package:sys_info_getter/src/utils/info_formater.dart';

class TerminalHelper {
  late final TerminalInterface _provider;

  TerminalHelper(TerminalProvider terminalProvider) {
    _provider = terminalProvider.interface;
  }

  Future<SystemInformations> update() async {
    List<DiskInfo>? diskInfo = await _getDiskInfo();

    return SystemInformations(diskInfo: diskInfo);
  }

  Future<List<DiskInfo>?> _getDiskInfo() async {
    List<DiskInfo> diskInfos = List.empty(growable: true);

    String output = await _provider.executeCommand(CmdConts.GET_VOLUME);
    if (output.isEmpty) return null;

    List<Map<String, String>> formatedInfos =
        InfoFormater.formatStringToInfoMap(output);

    for (Map<String, String> info in formatedInfos) {
      if (info["DriveLetter"]!.isEmpty) continue;
      diskInfos.add(DiskInfo.fromMap(info));
    }

    return diskInfos;
  }
}
