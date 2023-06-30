import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/horario.dart';

class CardConstanciaMatricula extends StatelessWidget {
  final String titulo;
  final String dia;
  final List<Horario> listHorario;
  final List<Horario> listDocente;

  const CardConstanciaMatricula({super.key, 
    required this.titulo,
    required this.dia,
    required this.listHorario,
    required this.listDocente,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today),
              SizedBox(
                width: 5,
              ),
              Text(
                titulo,
                style: TextStyle(
                  color: Color.fromRGBO(41, 45, 67, 1),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: listHorario.map(
              (item) {
                List listDia = [];
                if (dia == "lunes") {
                  listDia = getValueMatricula(item.lunes);
                } else if (dia == "martes") {
                  listDia = getValueMatricula(item.martes);
                } else if (dia == "miercoles") {
                  listDia = getValueMatricula(item.miercoles);
                } else if (dia == "jueves") {
                  listDia = getValueMatricula(item.jueves);
                } else if (dia == "viernes") {
                  listDia = getValueMatricula(item.viernes);
                } else if (dia == "sabado") {
                  listDia = getValueMatricula(item.sabado);
                } else {
                  listDia = getValueMatricula(item.domingo);
                }

                if (listDia.isNotEmpty) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.menu_book),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          listDia[2],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          formatHour(listDia[8]),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const Text(
                                          "a",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          formatHour(listDia[9]),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(Icons.av_timer)
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Docente:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 17,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        getValueDocente(
                                          listDia[2],
                                        ),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Ubicación:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 17,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        getValueLocalAula(
                                          listDia[2],
                                        ),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    height: 0,
                  );
                }
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  List getValueMatricula(var value) {
    if (value == null) return [];
    return value.split("_");
  }

  String getValueDocente(String asignatura) {
    String docente = "";
    for (var i = 0; i < listDocente.length; i++) {
      if (listDocente[i].asiAsignatura == asignatura) {
        docente = listDocente[i].docente!;
        break;
      }
    }
    return docente;
  }

  String getValueLocalAula(String asignatura) {
    String localaula = "";
    for (var i = 0; i < listDocente.length; i++) {
      if (listDocente[i].asiAsignatura == asignatura) {
        localaula = listDocente[i].local! + " - " + listDocente[i].aula!;
        break;
      }
    }
    return localaula;
  }
}
