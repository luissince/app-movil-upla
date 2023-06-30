class ProgresoAcademico {
  String codigo;
  String descripcion;

  ProgresoAcademico(this.codigo, this.descripcion);

  factory ProgresoAcademico.fromJson(Map<String, dynamic> json) {
    return ProgresoAcademico(json["codigo"], json["descripcion"]);
  }
}
