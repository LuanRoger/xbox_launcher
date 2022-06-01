import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) {
        return value.preferenceByImage && value.imageBackgroundPath != null
            ? Image.file(File(value.imageBackgroundPath!), fit: BoxFit.cover)
            : Container(
                color: value.solidColorBackground,
              );
      },
    );
  }
}
