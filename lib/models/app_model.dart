import 'package:xbox_launcher/shared/enums/app_type.dart';

abstract class AppModel {
  String name;
  AppType appType;

  AppModel(this.name, this.appType);
}
