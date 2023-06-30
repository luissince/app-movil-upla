import 'package:flutter/widgets.dart';
import 'package:upla/model/docente.dart';
import 'package:upla/model/escala.dart';

enum BestOpcionCalificacion { none, a, b, c, d, e }

class Pregunta {
  int? key;
  int? idPregunta;
  String? cNombrePregunta;
  int? idEscalaValores;
  String? cNombreEscala;
  int? puntajeEscala;
  int? idGrupoEscala;
  List<Docente>? listDocente;
  BestOpcionCalificacion? bestOpcionCalificacion;
  String? escala;
  Color? color;
  List<Escala>? listEscala;

  Pregunta(
    this.key,
    this.idPregunta,
    this.cNombrePregunta,
    this.idEscalaValores,
    this.cNombreEscala,
    this.puntajeEscala,
    this.idGrupoEscala,
    this.listDocente,
  );

  Pregunta.Only(
    this.key,
    this.idPregunta,
    this.cNombrePregunta,
  );

  Pregunta.Escala(
    this.key,
    this.idPregunta,
    this.cNombreEscala,
    this.puntajeEscala,
    this.bestOpcionCalificacion,
    this.escala,
    this.color,
  );
}
