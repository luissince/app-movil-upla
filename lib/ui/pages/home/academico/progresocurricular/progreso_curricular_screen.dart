import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';

class ProgresoCurrillarScreen extends StatefulWidget {
  static String id = "progreso_curricular_page";

  const ProgresoCurrillarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgresoCurrillarScreen> createState() => _PageFourPregresoState();
}

class _PageFourPregresoState extends State<ProgresoCurrillarScreen> {
  AppProvider? appProvider;

  String plan = "";
  String facultad = "";
  String carrera = "";

  bool loadingProgreso = false;
  bool responseProgresoOk = true;
  String messageProgreso = "";
  List<dynamic> progreso = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadProgreso();
    });
  }

  @override
  void dispose() async {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 248, 250, 1),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Progreso Curricular",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat",
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  /**
                   * 
                   */

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: loadingProgreso
                        ? Column(
                            children: const [
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
                        : !responseProgresoOk
                            ? Column(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Color.fromRGBO(254, 1, 3, 1),
                                    size: 37,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    messageProgreso,
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  /**
                                   * 
                                   */
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "FACULTAD DE $facultad",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "ESCUELA PROFESIONAL DE $carrera",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Progreso Curricular - Plan $plan",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  /**
                                   * 
                                   */

                                  Column(
                                    children: progreso.map((item) {
                                      // print(item["nivelAsign"]);
                                      List<dynamic> list =
                                          List.from(item["children"]);
                                      // print(item);
                                      return Column(
                                        children: [
                                          /**
                                           * 
                                           */

                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 213, 213, 213),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  listCiclos[
                                                      item["nivelAsign"] - 1],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          /**
                                           * 
                                           */

                                          SizedBox(
                                            height: 10,
                                          ),

                                          /**
                                           * 
                                           */

                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: list
                                                  .map(
                                                    (ciclo) => Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: ciclo["key"] ==
                                                                list.length
                                                            ? 0
                                                            : 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            width: ciclo[
                                                                        "key"] ==
                                                                    list.length
                                                                ? 0
                                                                : 1,
                                                            color: ciclo[
                                                                        "key"] ==
                                                                    list.length
                                                                ? Colors.white
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        234,
                                                                        234,
                                                                        234),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                "CÓDIGO:",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    ciclo[
                                                                        "codigoAsign"],
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "UNIDAD DE EJECUCIÓN CURRICULAR:",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 2,
                                                                child: Text(
                                                                  ciclo[
                                                                      "nombreAsign"],
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                "ESTADO:",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              )),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    ciclo["estadoAsign"]
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        color: ciclo["estadoAsign"] !=
                                                                                "concluido"
                                                                            ? Colors
                                                                                .red
                                                                            : Color.fromARGB(
                                                                                255,
                                                                                55,
                                                                                151,
                                                                                58),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),

                                          /**
                                           * 
                                           */
                                        ],
                                      );
                                    }).toList(),
                                  ),

                                  /**
                                   * 
                                   */
                                ],
                              ),
                  ),
                  /**
                   * 
                   */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadProgreso() async {
    if (loadingProgreso) {
      return;
    }

    setState(() {
      loadingProgreso = true;
      responseProgresoOk = false;
    });

    dynamic response = await appProvider!
        .estudianteProgresoCurricular(cancelToken: cancelToken);

    if (response is Response) {
      List<dynamic> list = response.data;
      List<dynamic> ciclos = [];
      String facultadCurrent = "";
      String carreraCurrent = "";
      String planCurrent = "";

      if (list.isNotEmpty) {
        facultadCurrent = list[0]["nombreFacultad"];
        carreraCurrent = list[0]["nombreCarrera"];
        planCurrent = list[0]["planEstudios"];

        for (var value in list) {
          if (!duplicado(ciclos, value["nivelAsign"])) {
            var object = {"nivelAsign": value["nivelAsign"], "children": []};
            ciclos.add(object);
          }
        }

        for (var ciclo in ciclos) {
          int count = 0;
          for (var value in list) {
            if (ciclo["nivelAsign"] == value["nivelAsign"]) {
              count++;
              var object = {
                "key": count,
                "nombreFacultad": value["nombreFacultad"],
                "nombreCarrera": value["nombreCarrera"],
                "planEstudios": value["planEstudios"],
                "estadoAsign": value["estadoAsign"],
                "tipoAsign": value["tipoAsign"],
                "nivelAsign": value["nivelAsign"],
                "codigoAsign": value["codigoAsign"],
                "nombreAsign": value["nombreAsign"],
                "creditosAsign": value["creditosAsign"],
                "seleccionado": value["seleccionado"],
                "estudiante": value["estudiante"],
              };
              ciclo["children"].add(object);
            }
          }
        }
      }

      setState(() {
        progreso = ciclos;
        facultad = facultadCurrent;
        carrera = carreraCurrent;
        plan = planCurrent;
        loadingProgreso = false;
        responseProgresoOk = true;
      });
    }

    if (response is RestError) {
      print(response.getType());
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        loadingProgreso = false;
        responseProgresoOk = false;
        messageProgreso = response.message;
      });
    }
  }

  bool duplicado(List<dynamic> list, int ciclo) {
    bool value = false;

    for (var object in list) {
      if (object["nivelAsign"] == ciclo) {
        value = true;
        break;
      }
    }

    return value;
  }
}
