import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';

class MallaCurricularScreen extends StatefulWidget {
  static String id = "malla_curricular_page";

  const MallaCurricularScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MallaCurricularScreen> createState() => _MallaCurricularScreenState();
}

class _MallaCurricularScreenState extends State<MallaCurricularScreen> {
  AppProvider? appProvider;

  String plan = "";
  String facultad = "";
  String carrera = "";

  bool loadingMalla = false;
  bool responseMallaOk = true;
  String messageMalla = "";
  List<dynamic> malla = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadMalla();
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
          "Malla Curricular",
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
                    child: loadingMalla
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
                        : !responseMallaOk
                            ? Column(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Color.fromRGBO(254, 1, 3, 1),
                                    size: 37,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    messageMalla,
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
                                        const EdgeInsets.symmetric(horizontal: 10),
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
                                          "Malla Curricular - Plan $plan",
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
                                    children: malla.map((item) {
                                      List<dynamic> list =
                                          List.from(item["children"]);
                                      return Column(
                                        children: [
                                          /**                                           
                                           *
                                           */
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 213, 213, 213),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "CICLO",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  item["cicloAsignatura"],
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 218, 14, 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          /**
                                           * 
                                           */
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          /**
                                           * 
                                           */
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Column(
                                                children: list
                                                    .map((ciclo) => Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            bottom: ciclo[
                                                                        "key"] ==
                                                                    list.length
                                                                ? 0
                                                                : 10,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                width: ciclo[
                                                                            "key"] ==
                                                                        list.length
                                                                    ? 0
                                                                    : 1,
                                                                color: ciclo[
                                                                            "key"] ==
                                                                        list
                                                                            .length
                                                                    ? Colors
                                                                        .white
                                                                    : const Color
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
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Asignatura:",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      ciclo[
                                                                          "nombreAsignatura"],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Créditos:",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      ciclo["creditosAsignatura"]
                                                                          .round()
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Tipo:",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      ciclo[
                                                                          "tipoAsignatura"],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            kPrimaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                            ],
                                                          ),
                                                        ))
                                                    .toList()),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
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

  Future<void> loadMalla() async {
    if (loadingMalla) {
      return;
    }

    setState(() {
      loadingMalla = true;
      responseMallaOk = false;
    });

    dynamic response =
        await appProvider!.estudianteMallaCurricular(cancelToken: cancelToken);

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
          if (!duplicado(ciclos, value["cicloAsignatura"])) {
            var object = {
              "cicloAsignatura": value["cicloAsignatura"],
              "children": []
            };
            ciclos.add(object);
          }
        }

        for (var ciclo in ciclos) {
          int count = 0;
          for (var value in list) {
            if (ciclo["cicloAsignatura"] == value["cicloAsignatura"]) {
              count++;
              var object = {
                "key": count,
                "nombreFacultad": value["nombreFacultad"],
                "nombreCarrera": value["nombreCarrera"],
                "planEstudios": value["planEstudios"],
                "cicloAsignatura": value["cicloAsignatura"],
                "nombreAsignatura": value["nombreAsignatura"],
                "creditosAsignatura": value["creditosAsignatura"],
                "tipoAsignatura": value["tipoAsignatura"],
                "asi_Tipo": value["asi_Tipo"]
              };
              ciclo["children"].add(object);
            }
          }
        }
      }

      setState(() {
        malla = ciclos;
        facultad = facultadCurrent;
        carrera = carreraCurrent;
        plan = planCurrent;
        loadingMalla = false;
        responseMallaOk = true;
      });

      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        loadingMalla = false;
        responseMallaOk = false;
        messageMalla = response.message;
      });
    }
  }

  bool duplicado(List<dynamic> list, String ciclo) {
    bool value = false;

    for (var object in list) {
      if (object["cicloAsignatura"] == ciclo) {
        value = true;
        break;
      }
    }

    return value;
  }
}
