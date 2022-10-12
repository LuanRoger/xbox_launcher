import 'package:sys_info_getter/src/enums/get_error.dart';
import 'package:sys_info_getter/src/models/disk_info.dart';

class SystemInformations {
  final List<DiskInfo>? diskInfo;
  
  late List<GetError> _errors;
  List<GetError> get errors => List.from(_errors);

  SystemInformations({this.diskInfo}) {
    _errors = List.empty(growable: true);
    if (diskInfo == null) {
      _errors.add(GetError.GET_DISK_INFO_ERROR);
    }
  }
}
