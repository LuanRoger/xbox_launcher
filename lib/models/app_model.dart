import 'package:xbox_launcher/shared/enums/app_type.dart';

abstract class AppModel {
  late String name;
  late AppType appType;

  AppModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
