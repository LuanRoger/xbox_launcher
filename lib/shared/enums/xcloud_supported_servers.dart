enum XCloudSupportedServers {
  EN_US("en-US"),
  PT_BR("pt-BR");

  final String countryCode;

  const XCloudSupportedServers(this.countryCode);

  factory XCloudSupportedServers.fromIndex(int index) =>
      XCloudSupportedServers.values
          .firstWhere((server) => server.index == index);
}
