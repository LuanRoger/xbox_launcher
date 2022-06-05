import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class ProfileAvatar extends CircleAvatar {
  Color accentColor;
  String? profileImagePath;

  ProfileAvatar({Key? key, required this.accentColor, this.profileImagePath})
      : super(
          key: key,
          backgroundColor: accentColor,
          backgroundImage: profileImagePath != null
              ? Image.file(File(profileImagePath)).image
              : null,
        );
}
