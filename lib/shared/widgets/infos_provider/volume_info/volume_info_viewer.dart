import 'package:fluent_ui/fluent_ui.dart';
import 'package:sys_info_getter/sys_info_getter.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/utils/disk_size_formatter.dart';

class VolumeInfoViwer extends StatelessWidget {
  final DiskInfo diskInfo;

  const VolumeInfoViwer(this.diskInfo, {super.key});

  String get formatedBytes =>
      DiskSizeFormatter.formatBytes(diskInfo.sizeRemaining, 1);
  double get percentageRemaining =>
      (diskInfo.sizeRemaining * 100) / diskInfo.size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 250,
      child: OutlinedButton(
        style: ButtonStyle(border: ButtonState.all(BorderSide.none)),
        onPressed: () {}, // This is just for focus.
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Volume: ${diskInfo.driveLetter}\n$formatedBytes free",
                      style: AppTextStyle.VOLUME_INFOS,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    ProgressRing(
                      value: percentageRemaining,
                      backgroundColor: Colors.green,
                      activeColor: Colors.green,
                      strokeWidth: 3,
                    ),
                    Center(
                        child: Text(
                      percentageRemaining.toStringAsFixed(1) + "%",
                      style: AppTextStyle.VOLUME_PERCENTAGE,
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
