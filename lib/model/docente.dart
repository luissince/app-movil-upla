
import 'package:upla/model/pregunta.dart';

class Docente {
  int? key;
  int? cLe_Auto;
  String? asi_Id;
  String? asi_Asignatura;
  String? per_Id;
  String? nombre;
  String? sed_Id;
  String? car_Id;
  String? mAc_Id;
  String? nta_Nivel;
  String? nta_Seccion;
  String? tipoDocente;
  List<Pregunta>? listPregunta;
  BestOpcionCalificacion bestOpcionCalificacion;

  Docente(
    this.key,
    this.cLe_Auto,
    this.asi_Id,
    this.asi_Asignatura,
    this.per_Id,
    this.nombre,
    this.sed_Id,
    this.car_Id,
    this.mAc_Id,
    this.nta_Nivel,
    this.nta_Seccion,
    this.tipoDocente,
    this.listPregunta,
    this.bestOpcionCalificacion,
  );
}
