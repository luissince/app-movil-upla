class Consulta {
  int key;
  String idConsulta;
  dynamic ticket;
  String asunto;
  int? tipoConsulta;
  String tipoConsultaDetalle;
  String? descripcion;
  int? estado;
  String fecha;
  String hora;
  String? estId;
  String? cCodUsuario;

  Consulta(
    this.key,
    this.idConsulta,
    this.ticket,
    this.asunto,
    this.tipoConsulta,
    this.tipoConsultaDetalle,
    this.descripcion,
    this.estado,
    this.fecha,
    this.hora,
    this.estId,
    this.cCodUsuario,
  );

  Consulta.newConsulta(
    this.key,
    this.idConsulta,
    this.ticket,
    this.asunto,
    this.tipoConsultaDetalle,
    this.fecha,
    this.hora,
  );

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta.newConsulta(
      json["id"],
      json["idConsulta"],
      json["ticket"],
      json["asunto"],
      json["tipoConsultaDetalle"],
      json["fecha"],
      json["hora"],
    );
  }
}
