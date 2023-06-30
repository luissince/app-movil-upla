class EncuestaPreguntaDetalle {
  String sed_id;
  String mac_id;
  String car_id;
  String per_id;
  String asi_id;
  String nivel;
  String seccion;
  String preg;
  String escala;
  EncuestaPreguntaDetalle(
    this.sed_id,
    this.mac_id,
    this.car_id,
    this.per_id,
    this.asi_id,
    this.nivel,
    this.seccion,
    this.preg,
    this.escala,
  );

  Map<String, dynamic> toJson() => {
        "sed_id": sed_id,
        "mac_id": mac_id,
        "car_id": car_id,
        "per_id": per_id,
        "asi_id": asi_id,
        "nivel": nivel,
        "seccion": seccion,
        "preg": preg,
        "escala": escala,
      };
}
