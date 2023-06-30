class DatosFicha {
  String codigo;
  String apellidoPaterno;
  String apellidoMaterno;
  String nombres;
  String fechaNacimiento;
  String telefono;
  String celular;
  String mail;
  String fechaIngreso;
  String facultad;
  String carrera;
  String modalidadAcademico;
  String direccion;
  String estadoCivil;
  String dni;
  String edad;

  DatosFicha(
    this.codigo,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.nombres,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.mail,
    this.fechaIngreso,
    this.facultad,
    this.carrera,
    this.modalidadAcademico,
    this.direccion,
    this.estadoCivil,
    this.dni,
    this.edad,
  );

  factory DatosFicha.fromJson(Map<String, dynamic> json) {
    return DatosFicha(
      json["codido"]??"",
      json["apellidoPaterno"]??"",
      json["apellidoMaterno"]??"",
      json["nombres"]??"",
      json["fechaNacimiento"]??"",
      json["telefono"]??"",
      json["celular"]??"",
      json["mail"]??"",
      json["fechaIngreso"]??"",
      json["facultad"]??"",
      json["carrera"]??"",
      json["modalidadAcademico"]??"",
      json["direccion"]??"",
      json["estadoCivil"]??"",
      json["dni"]??"",
      json["edad"]??"",
    );
  }
}
