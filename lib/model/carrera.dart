class Carrera {
  String codigo;
  String facultad;
  String carrera;
  String planEst;
  String ciclo;
  String especialidad;
  String periodo;
  String anio;

  Carrera(
    this.codigo,
    this.facultad,
    this.carrera,
    this.planEst,
    this.ciclo,
    this.especialidad,
    this.periodo,
    this.anio,
  );

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      json["codigo"],
      json["facultad"],
      json["carrera"],
      json["planEst"],
      json["ciclo"],
      json["especialidad"],
      json["periodo"],
      json["anio"],
    );
  }
}
