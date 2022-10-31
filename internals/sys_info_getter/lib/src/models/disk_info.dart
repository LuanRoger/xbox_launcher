class DiskInfo {
  final String driveLetter;
  final String operationalStatus;
  final double size;
  final double sizeRemaining;

  DiskInfo(
      {required this.driveLetter,
      required this.operationalStatus,
      required this.size,
      required this.sizeRemaining});

  factory DiskInfo.fromMap(Map<String, String> map) => DiskInfo(
      driveLetter: map["DriveLetter"]!,
      operationalStatus: map["OperationalStatus"]!,
      size: double.parse(map["Size"]!),
      sizeRemaining: double.parse(map["SizeRemaining"]!));
}
