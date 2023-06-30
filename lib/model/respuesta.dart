class Respuesta {
  int? key;
  int? idRespuesta;
  String? idConsulta;
  String? c_cod_usuario;
  String? detalle;
  String? fecha;
  String? hora;

  Respuesta(
    this.key,
    this.idRespuesta,
    this.idConsulta,
    this.c_cod_usuario,
    this.detalle,
    this.fecha,
    this.hora,
  );

  Respuesta.detalle(
    this.key,
    this.detalle,
  );

  factory Respuesta.fromJson(Map<String, dynamic> json) {
    return Respuesta(
      json["id"],
      json["idRespuesta"] == null ? "" : json["idRespuesta"],
      json["idConsulta"] == null ? "" : json["idConsulta"],
      json["c_cod_usuario"] == null ? "" : json["c_cod_usuario"],
      json["detalle"] == null ? "" : json["detalle"],
      json["fecha"] == null ? "" : json["fecha"],
      json["hora"] == null ? "" : json["hora"],
    );
  }
}
