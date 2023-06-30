import 'package:upla/constants.dart';

class Curso {
  String nombreFacultad;
  String nombreCarrera;
  String planEstudios;
  String codigo;
  String asignatura;
  String plan;
  String ciclo;
  String seccion;
  double credito;
  String asistencia;
  String pF1;
  String pF2;
  String pf;
  String complementario;
  String pfp;
  bool cc;
  String cicloTotal;
  String seccionTotal;
  int creditosTotal;
  String mtr_Anio;
  String mtr_Periodo;
  String tipoAsignatura;
  String tar_id;
  String puesto;

  Curso(
    this.nombreFacultad,
    this.nombreCarrera,
    this.planEstudios,
    this.codigo,
    this.asignatura,
    this.plan,
    this.ciclo,
    this.seccion,
    this.credito,
    this.asistencia,
    this.pF1,
    this.pF2,
    this.pf,
    this.complementario,
    this.pfp,
    this.cc,
    this.cicloTotal,
    this.seccionTotal,
    this.creditosTotal,
    this.mtr_Anio,
    this.mtr_Periodo,
    this.tipoAsignatura,
    this.tar_id,
    this.puesto,
  );

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      nullToString(json["nombreFacultad"]),
      nullToString(json["nombreCarrera"]),
      nullToString(json["planEstudios"]),
      nullToString(json["codigo"]),
      nullToString(json["asignatura"]),
      nullToString(json["plan"]),
      nullToString(json["ciclo"]),
      nullToString(json["seccion"]),
      nullToDouble(json["credito"]),
      nullToString(json["asistencia"]),
      nullToString(json["pF1"]),
      nullToString(json["pF2"]),
      nullToString(json["pf"]),
      nullToString(json["complementario"]),
      nullToString(json["pfp"]),
      nullToBoolean(json["cc"]),
      nullToString(json["cicloTotal"]),
      nullToString(json["seccionTotal"]),
      nullToInt(json["creditosTotal"]),
      nullToString(json["mtr_Anio"]),
      nullToString(json["mtr_Periodo"]),
      nullToString(json["tipoAsignatura"]),
      nullToString(json["tar_id"]),
      nullToString(json["puesto"]),
    );
  }
}
