import 'package:fluent_ui/fluent_ui.dart';
import 'package:sys_info_getter/sys_info_getter.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/volume_info/volume_info_viewer.dart';

class VolumeInfoList extends StatelessWidget {
  final List<DiskInfo> diskInfos;

  const VolumeInfoList({super.key, required this.diskInfos});

  List<VolumeInfoViwer> createViwers() =>
      diskInfos.map((infos) => VolumeInfoViwer(infos)).toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,      
      children: createViwers(),
    );
  }
}
