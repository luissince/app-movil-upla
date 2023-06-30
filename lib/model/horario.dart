class Horario {
  int? key;
  int? codigo;
  String? codAsignatura;
  String? codSalon;
  String? curso;
  String? observacion;
  String? lunes;
  String? martes;
  String? miercoles;
  String? jueves;
  String? viernes;
  String? sabado;
  String? domingo;
  String? hrInicio;
  String? hrTermino;

  String? asiAsignatura;
  String? local;
  String? aula;
  String? abservacion;
  String? docente;

  Horario(this.key, this.codAsignatura, this.codSalon, this.curso,
      this.observacion, this.hrInicio, this.hrTermino);

  Horario.newHorario(
      this.codigo,
      this.hrInicio,
      this.hrTermino,
      this.lunes,
      this.martes,
      this.miercoles,
      this.jueves,
      this.viernes,
      this.sabado,
      this.domingo);

  Horario.newDocente(this.asiAsignatura, this.local, this.aula,
      this.abservacion, this.docente);
}
