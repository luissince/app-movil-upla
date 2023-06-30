class Version {
  int idVersion;
  String appName;
  String packageName;
  String version;
  String buildNumber;

  Version(
    this.idVersion,
    this.appName,
    this.packageName,
    this.version,
    this.buildNumber,
  );

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      json["idVersion"],
      json["appName"],
      json["packageName"],
      json["version"],
      json["buildNumber"],
    );
  }
}
