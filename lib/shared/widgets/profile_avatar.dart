import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class ProfileAvatar extends CircleAvatar {
  Color accentColor;
  String? profileImagePath;
  double? radiusSize;

  ProfileAvatar(
      {Key? key,
      required this.accentColor,
      this.radiusSize,
      this.profileImagePath})
      : super(
          key: key,
          radius: radiusSize,
          backgroundColor: accentColor,
          backgroundImage: profileImagePath != null
              ? Image.file(File(profileImagePath)).image
              : null,
        );
}
