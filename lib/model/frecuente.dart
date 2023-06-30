class Frecuente {
  int id;
  String idFrecuenta;
  String asunto;
  String descripcion;
  int estado;
  String fecha;
  String hora;
  String c_cod_usuario;

  bool expandir = false;

  Frecuente(
    this.id,
    this.idFrecuenta,
    this.asunto,
    this.descripcion,
    this.estado,
    this.fecha,
    this.hora,
    this.c_cod_usuario,
  );

  factory Frecuente.fromJson(Map<String, dynamic> json) {
    return Frecuente(
      json["id"] ?? 0,
      json["idFrecuenta"] ?? "",
      json["asunto"] ?? "",
      json["descripcion"] ?? "",
      json["estado"] ?? "",
      json["fecha"] ?? "",
      json["hora"] ?? "",
      json["c_cod_usuario"] ?? "",
    );
  }
}
