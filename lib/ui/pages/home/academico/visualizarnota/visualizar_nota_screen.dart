import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/carrera.dart';
import 'package:upla/model/curso.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';

class VisualizarNotaScreen extends StatefulWidget {
  static String id = "visualizar_nota_page";

  const VisualizarNotaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VisualizarNotaScreen> createState() => _VisualizarNotaScreenState();
}

class _VisualizarNotaScreenState extends State<VisualizarNotaScreen> {
  AppProvider? appProvider;

  bool loadingInfo = false;
  bool responseInfoOk = true;
  String messageInfo = "";
  String plan = "";
  String facultad = "";
  String carrera = "";
  String ciclo = "";

  bool loadingCursos = false;
  bool responseCursosOk = true;
  String messageCurso = "";
  List<Curso> listCurso = [];

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadInformation();
      loadCursos();
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
          "Notas",
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
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: loadingInfo
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
                        : !responseInfoOk
                            ? Column(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Color.fromRGBO(254, 1, 3, 1),
                                    size: 37,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    messageInfo,
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
                                  const Text(
                                    "Universidad Peruana Los Andes",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(41, 45, 67, 1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "REPORTE DE NOTAS $plan",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(41, 45, 67, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Facultad:",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          facultad,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Carr./ Esp:",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          carrera,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Código:",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          appProvider!.session.docNumId!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Nombre:",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "${appProvider!.session.persNombre} ${appProvider!.session.persPaterno} ${appProvider!.session.persMaterno}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color:
                                                Color.fromRGBO(41, 45, 67, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                  ),

                  /**
                 * 
                 */
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: loadingCursos
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
                        : !responseCursosOk
                            ? Column(
                                children: [
                                  const Icon(
                                    Icons.warning,
                                    color: Color.fromRGBO(254, 1, 3, 1),
                                    size: 37,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    messageCurso,
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: listCurso
                                    .map(
                                      (item) => Column(
                                        children: [
                                          /**
                                           * 
                                           */
                                          Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Código:",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  item.codigo,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          /**
                                            * 
                                            */
                                          Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Asignatura:",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  item.asignatura,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          /**
                                           * plan
                                           */
                                          const Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Plan",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Cic",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Sec",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Cred",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Asist",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.plan,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.ciclo,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.seccion,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${item.asistencia}%",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${item.asistencia}%",
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          /**
                                           * 
                                           */
                                          const Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "PF1",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "PF2",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Prom",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Com",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "PFP",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  item.pF1,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.pF2,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.pf,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.complementario,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.pfp,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                            ],
                                          ),

                                          /**
                                           * 
                                           */
                                          Column(
                                            children: [
                                              Icon(
                                                item.cc
                                                    ? Icons.done
                                                    : Icons.close,
                                                size: 34,
                                                color: item.cc
                                                    ? const Color.fromRGBO(
                                                        13, 206, 122, 1)
                                                    : const Color.fromRGBO(
                                                        252, 2, 10, 1),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                item.cc ? "APROBADO" : "---",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      23, 62, 97, 1),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),

                                          /**
                                           * 
                                           */
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
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

  Future<void> loadInformation() async {
    if (loadingInfo) {
      return;
    }

    setState(() {
      loadingInfo = true;
      responseInfoOk = false;
    });

    dynamic response =
        await appProvider!.mostrarFacultad(cancelToken: cancelToken);

    if (response is Response) {
      if (response.statusCode == 204) {
        setState(() {
          loadingInfo = false;
          responseInfoOk = true;
          messageInfo = "Información sin contenido";
        });
        return;
      }

      var data = response.data;

      Carrera car = Carrera.fromJson(data);

      setState(() {
        plan = "${car.planEst}-${car.periodo}";
        ciclo = "${car.anio}-${car.ciclo}";
        facultad = car.facultad;
        carrera = car.carrera;
        loadingInfo = false;
        responseInfoOk = true;
      });

      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        loadingInfo = false;
        responseInfoOk = false;
        messageInfo = response.message;
      });

      return;
    }
  }

  Future<void> loadCursos() async {
    if (loadingCursos) {
      return;
    }

    setState(() {
      loadingCursos = true;
      responseCursosOk = true;
    });

    dynamic response =
        await appProvider!.estudianteConstancia(cancelToken: cancelToken);

    if (response is Response) {
      List<dynamic> list = response.data;

      List<Curso> newListCurso = [];

      for (var item in list) {
        newListCurso.add(Curso.fromJson(item));
      }

      setState(() {
        listCurso = newListCurso;
        loadingCursos = false;
        responseCursosOk = true;
      });
      return;
    }

    if (response is Map) {
      if (response["type"] == DioErrorType.cancel) return;

      setState(() {
        listCurso = [];
        loadingCursos = false;
        responseCursosOk = false;
        messageCurso = response["message"];
      });
      return;
    }

    if (response is String) {
      setState(() {
        listCurso = [];
        loadingCursos = false;
        responseCursosOk = false;
        messageCurso = response;
      });
    }
  }
}
