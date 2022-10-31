class InfoFormater {
  static List<Map<String, String>> formatStringToInfoMap(String rawInfo,
      {String separator = ":"}) {
    List<Map<String, String>> infos = List.empty(growable: true);
    List<String> diskInfos = rawInfo.trim().split("\n");

    Map<String, String> buffer = {};
    for (String lineInfo in diskInfos) {
      if (lineInfo.trim().isEmpty) {
        infos.add(Map.from(buffer));
        buffer.clear();
        continue;
      }

      List<String> keyValue = lineInfo.split(separator);
      String key = keyValue[0].trim();
      String value = keyValue[1].trim();
      buffer[key] = value;
    }
    infos.add(buffer);

    return infos;
  }
}
