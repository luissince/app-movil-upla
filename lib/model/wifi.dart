class Wifi {
  String codigo;
  String password;
  String estado;

  Wifi(this.codigo, this.password, this.estado);

  factory Wifi.fromJson(Map<String, dynamic> json) {
    return Wifi(
      json["codigo"],
      json["password"],
      json["estado"],
    );
  }
}
