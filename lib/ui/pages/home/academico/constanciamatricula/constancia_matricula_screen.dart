import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/carrera.dart';
import 'package:upla/model/horario.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';

import 'widget/body_constancia_matricula.dart';
import 'widget/card_constancia_matricula.dart';
import 'widget/head_constancia_matricula.dart';
import 'widget/title_constancia_matricula.dart';

class ConstanciaMatriculaScreen extends StatefulWidget {
  static String id = "constancia_matricula_page";

  const ConstanciaMatriculaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConstanciaMatriculaScreen> createState() =>
      _ConstanciaMatriculaScreenState();
}

class _ConstanciaMatriculaScreenState extends State<ConstanciaMatriculaScreen> {
  AppProvider? appProvider;

  ScrollController scrollController = ScrollController();

  bool loadingInfo = false;
  bool responseInfoOk = true;
  String messageInfo = "";
  String plan = "";
  String ciclo = "";
  String facultad = "";
  String carrera = "";

  bool loadingHorario = false;
  bool responseHorarioOk = true;
  String messageHorario = "";
  List<Horario> listHorarios = [];

  bool loadingDocente = false;
  bool responseDocenteOk = true;
  String messageDocente = "";
  List<Horario> listDocente = [];

  CancelToken cancelToken = CancelToken();

  int year = 0;
  int month = 0;
  int day = 0;

  int weekday = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadInformation();
      loadHorario();
      loadDocente();

      final DateTime now = DateTime.now();
      year = now.year;
      month = now.month;
      day = now.day;
      weekday = now.weekday;
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

    return BodyConstanciaMatricula(
      onRefresh: () async {},
      children: [
        TitleConstanciaMatricula(
          plan: plan,
        ),
        HeadConstanciaMatricula(
          loading: loadingInfo,
          responde: responseInfoOk,
          message: messageInfo,
          facultad: facultad,
          carrera: carrera,
          docNumId: appProvider!.session.docNumId!,
          persNombre: appProvider!.session.persNombre!,
          persPaterno: appProvider!.session.persPaterno!,
          persMaterno: appProvider!.session.persMaterno!,
        ),
        const SizedBox(
          height: 20,
        ),
        CuerpoWidget()
      ],
    );
  }

  Widget CuerpoWidget() {
    if (loadingHorario) {
      return const Column(
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
      );
    }

    if (!responseHorarioOk) {
      return Column(
        children: [
          const Icon(
            Icons.warning,
            color: Color.fromRGBO(254, 1, 3, 1),
            size: 37,
          ),
          Text(
            textAlign: TextAlign.center,
            messageHorario,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
    }

    return Column(
      children: [
        CardConstanciaMatricula(
          titulo: "Lunes",
          dia: "lunes",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Martes",
          dia: "martes",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Miercoles",
          dia: "miercoles",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Jueves",
          dia: "jueves",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Viernes",
          dia: "viernes",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Sábado",
          dia: "sabado",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
        CardConstanciaMatricula(
          titulo: "Domingo",
          dia: "domingo",
          listHorario: listHorarios,
          listDocente: listDocente,
        ),
      ],
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

  Future<void> loadHorario() async {
    if (loadingHorario) {
      return;
    }

    setState(() {
      loadingHorario = true;
      responseHorarioOk = true;
    });

    dynamic response =
        await appProvider!.estudianteHorario(cancelToken: cancelToken);

    if (response is Response) {
      List<dynamic> list = response.data;

      List<Horario> newListHorarios = [];
      for (var item in list) {
        Map<String, dynamic> addjson = item;
        newListHorarios.add(Horario.newHorario(
            addjson["cod_hor"],
            addjson["hora_ini"],
            addjson["hora_fin"],
            addjson["lunes"],
            addjson["martes"],
            addjson["miercoles"],
            addjson["jueves"],
            addjson["viernes"],
            addjson["sabado"],
            addjson["domingo"]));
      }

      setState(() {
        listHorarios = newListHorarios;
        loadingHorario = false;
        responseHorarioOk = true;
      });

      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        listHorarios = [];
        loadingHorario = false;
        responseHorarioOk = false;
        messageHorario = response.message;
      });
    }
  }

  Future<void> loadDocente() async {
    if (loadingDocente) {
      return;
    }
    setState(() {
      loadingDocente = true;
      responseDocenteOk = true;
    });

    dynamic response =
        await appProvider!.estudianteHorarioDetalle(cancelToken: cancelToken);

    if (response is Response) {
      List<dynamic> list = response.data;

      List<Horario> newListDocente = [];
      for (var item in list) {
        Map<String, dynamic> addjson = item;
        newListDocente.add(
          Horario.newDocente(
            addjson["asi_Asignatura"],
            addjson["local"],
            addjson["aula"],
            addjson["obs"],
            addjson["docente"],
          ),
        );
      }

      setState(() {
        listDocente = newListDocente;
        loadingDocente = false;
        responseDocenteOk = true;
      });

      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        listDocente = [];
        loadingDocente = false;
        responseDocenteOk = false;
        messageDocente = response.message;
      });
    }
  }
}

        /**
                   * 
                   */
        // Padding(
        //   padding: const EdgeInsets.only(top: 10, bottom: 10),
        //   child: SingleChildScrollView(
        //     controller: scrollController,
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         ElevatedButton(
        //           onPressed: () {},
        //           style: ElevatedButton.styleFrom(
        //             primary: kPrimaryColor,
        //             elevation: 0,
        //             padding: const EdgeInsets.all(10),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //           ),
        //           child: Container(
        //             padding: const EdgeInsets.all(10),
        //             child: const Text(
        //               "Lunes",
        //               style: TextStyle(
        //                 color:
        //                     Color.fromARGB(255, 255, 255, 255),
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Martes",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Miercoles",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Jueves",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Viernes",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Sábado",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           padding: const EdgeInsets.all(15),
        //           child: const Text(
        //             "Domingo",
        //             style: TextStyle(
        //               color: Color.fromRGBO(41, 45, 67, 1),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),