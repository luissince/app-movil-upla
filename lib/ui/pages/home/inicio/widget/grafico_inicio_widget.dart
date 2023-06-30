import 'package:flutter/material.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/curso.dart';
import 'package:upla/ui/components/activity_indicator.dart';

class GraficoInicioWidget extends StatelessWidget {
  final bool loading;
  final bool valid;
  final String message;
  final List<Curso> list;

  const GraficoInicioWidget({super.key, 
    required this.loading,
    required this.valid,
    required this.message,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: const Text(
            "Metodología del Estudio Universitario",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: loading
              ? const Column(
                  children: [
                    ActivityIndicator(
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Cargando Información...",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /**
                             * 
                             */
                    const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Resultado Gráficos",
                                    style: TextStyle(
                                      color: Color.fromRGBO(43, 96, 201, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /**
                               * 
                               */
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lens,
                              color: Color.fromRGBO(255, 203, 203, 1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Muy Alto",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /**
                               * 
                               */
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lens,
                              color: Color.fromRGBO(255, 229, 203, 1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Alto",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /**
                               * 
                               */
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lens,
                              color: Color.fromRGBO(255, 251, 203, 1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Medio",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /**
                               * 
                               */
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lens,
                              color: Color.fromRGBO(222, 249, 220, 1),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Bajo",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /**
                               * 
                               */
                    const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                "Item",
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 96, 201, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                "Asignatura",
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 96, 201, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                "P1",
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 96, 201, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                "PF",
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 96, 201, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text(
                                "A/S",
                                style: TextStyle(
                                    color: Color.fromRGBO(43, 96, 201, 1),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    list.isEmpty
                        ? const Row(
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "No tiene cursos disponibles.",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : !valid
                            ? Column(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Color.fromRGBO(254, 1, 3, 1),
                                    size: 37,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    message,
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: list
                                    .map(
                                      (item) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.codigo,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.asignatura,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.pF1,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.pf,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${item.asistencia}%",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          /**
                                                 * 
                                                 */
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                  ],
                ),
        ),
      ],
    );
  }
}
