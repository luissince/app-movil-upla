import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/model/carrera.dart';
import 'package:upla/model/progreso_academico.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/inicio/widget/grafico_inicio_widget.dart';
import 'package:upla/ui/pages/home/inicio/widget/informacion_inicio_widget.dart';
import 'package:upla/ui/pages/home/widget/headboard_home.dart';

import '../../../../constants.dart';
import '../../../../model/curso.dart';
import '../../../../model/horario.dart';
import '../widget/background_home.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen>
    with AutomaticKeepAliveClientMixin {
  AppProvider? appProvider;

  CancelToken cancelToken = CancelToken();

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

  bool loadingCursos = false;
  bool responseCursosOk = true;
  String listCursos = "";
  List<Curso> listCurso = [];

  List<ProgresoAcademico> listProgresoAcademico = [];

  int year = 0;
  int month = 0;
  int day = 0;

  int weekday = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInformation();
      loadHorario();
      loadCursos();
      loadProgresoAcademico();
      loadPublicacion();
    });

    final DateTime now = DateTime.now();
    year = now.year;
    month = now.month;
    day = now.day;
    weekday = now.weekday;
  }

  @override
  void dispose() {
    super.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return BackgroundHome(
      onRefresh: () async {
        loadInformation();
        loadCursos();
        loadHorario();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /**
           * 
           */
          HeadBoardHome(
            size: size,
            docNumId: appProvider!.session.docNumId!,
            bottom: 10,
          ),
          /**
           * inicio
           */
          InformacionInicioWidget(
            loading: loadingInfo,
            valid: responseInfoOk,
            message: messageInfo,
            docNumId: appProvider!.session.docNumId!,
            persNombre: appProvider!.session.persNombre!,
            persPaterno: appProvider!.session.persPaterno!,
            persMaterno: appProvider!.session.persMaterno!,
            plan: plan,
            ciclo: ciclo,
            facultad: facultad,
            carrera: carrera,
          ),
          /**
           * 
           */
          _widgetFechaActual(),
          /**
           * 
           */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  "Horario y Turnos",
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
                child: _widgetHorarioTurnos(),
              ),
            ],
          ),

          /**
           * 
           */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  "Progreso Académico",
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: _contendorProgresoAcademico(),
                ),
              ),
            ],
          ),
          /**
           * 
           */
          GraficoInicioWidget(
            loading: loadingCursos,
            valid: responseCursosOk,
            message: listCursos,
            list: listCurso,
          ),
          /**
           * 
           */
        ],
      ),
    );
  }

  Widget _contendorProgresoAcademico() {
    List<Widget> rowChildren = [];
    rowChildren.add(_contenedorItemPA("assets/icons/estudiante.png",
        "Estudiante", "En Proceso", Colors.green));

    if (listProgresoAcademico.isEmpty) {
      rowChildren.add(_contenedorItemPA(
          "assets/icons/egresado.png", "Egresado(a)", "Faltante", Colors.red));

      rowChildren.add(_contenedorItemPA("assets/icons/bachiller.png",
          "Bachiller(a)", "Faltante", Colors.red));

      rowChildren.add(_contenedorItemPA(
          "assets/icons/titulado.png", "Titulado(a)", "Faltante", Colors.red));
    } else {
      for (ProgresoAcademico progresoAcademico in listProgresoAcademico) {
        if (progresoAcademico.codigo == "0") {
          rowChildren.add(_contenedorItemPA("assets/icons/egresado.png",
              "Egresado(a)", "Completado", Colors.green));
        } else {
          rowChildren.add(_contenedorItemPA("assets/icons/egresado.png",
              "Egresado(a)", "Faltante", Colors.red));
        }

        if (progresoAcademico.codigo == "1") {
          rowChildren.add(_contenedorItemPA("assets/icons/bachiller.png",
              "Bachiller(a)", "Completado", Colors.green));
        } else {
          rowChildren.add(_contenedorItemPA("assets/icons/bachiller.png",
              "Bachiller(a)", "Faltante", Colors.red));
        }

        if (progresoAcademico.codigo == "2") {
          rowChildren.add(_contenedorItemPA("assets/icons/titulado.png",
              "Titulado(a)", "Completado", Colors.green));
        } else {
          rowChildren.add(_contenedorItemPA("assets/icons/titulado.png",
              "Titulado(a)", "Faltante", Colors.red));
        }
      }
    }

    return Row(
      children: rowChildren,
    );
  }

  Widget _widgetFechaActual() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: const Text(
            "Fecha Actual",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 13, 206, 122),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$day ${listMonth[month - 1]} $year",
                          style: const TextStyle(
                            color: Color.fromRGBO(43, 96, 201, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _contenedorItemPA(
      String image, String titulo, String estado, Color color) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffffffff)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Image.asset(image),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              estado,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetHorarioTurnos() {
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
          ),
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

    if (listHorarios.isEmpty) {
      return const Row(
        children: [
          Icon(Icons.info),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "No tiene horarios para hoy.",
              style: TextStyle(
                color: Color.fromRGBO(43, 96, 201, 1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: listHorarios.map((Horario item) => _itemHorario(item)).toList(),
    );
  }

  Widget _itemHorario(Horario item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.punch_clock,
          size: 32,
          color: Color.fromRGBO(214, 58, 108, 1),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.curso!,
                style: const TextStyle(
                  color: Color.fromRGBO(42, 49, 73, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                item.observacion!,
                style: const TextStyle(
                  color: Color.fromRGBO(43, 96, 201, 1),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formatHour(item.hrInicio!),
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 49, 73, 0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Text(
                    formatHour(item.hrTermino!),
                    style: const TextStyle(
                      color: Color.fromRGBO(42, 49, 73, 0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: item.key == listHorarios.length ? 0 : 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadInformation() async {
    if (loadingInfo) return;

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

      Carrera car = Carrera.fromJson(response.data);

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
    }
  }

  Future<void> loadHorario() async {
    if (loadingHorario) return;

    setState(() {
      loadingHorario = true;
      responseHorarioOk = true;
    });

    dynamic response = await appProvider!.estudianteHorario();

    if (response is Response) {
      var data = response.data;

      List<Horario> newListHorarios = [];
      int count = 0;

      for (var item in data) {
        Map<String, dynamic> json = item;
        if (listWeekdays[weekday - 1] == json.keys.elementAt(3)) {
          if (json["lunes"] != null) {
            count++;
            var arr = json["lunes"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(4)) {
          if (json["martes"] != null) {
            count++;
            var arr = json["martes"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(5)) {
          if (json["miercoles"] != null) {
            count++;
            var arr = json["miercoles"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(6)) {
          if (json["jueves"] != null) {
            count++;
            var arr = json["jueves"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(7)) {
          if (json["viernes"] != null) {
            count++;
            var arr = json["viernes"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(8)) {
          if (json["sabado"] != null) {
            count++;
            var arr = json["sabado"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }

        if (listWeekdays[weekday - 1] == json.keys.elementAt(9)) {
          if (json["domingo"] != null) {
            count++;
            var arr = json["domingo"].split("_");
            newListHorarios.add(Horario(
                count, arr[0], arr[1], arr[2], arr[13], arr[8], arr[9]));
          }
        }
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
        responseHorarioOk = true;
        messageHorario = response.message;
      });
    }
  }

  Future<void> loadCursos() async {
    if (loadingCursos) return;

    setState(() {
      loadingCursos = true;
      responseCursosOk = true;
    });

    dynamic response = await appProvider!.estudianteConstancia();

    if (response is Response) {
      var data = response.data;

      List<Curso> newListCurso = [];

      for (var item in data) {
        newListCurso.add(Curso.fromJson(item));
      }

      setState(() {
        listCurso = newListCurso;
        loadingCursos = false;
        responseCursosOk = true;
      });

      return;
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        listCurso = [];
        loadingCursos = false;
        responseCursosOk = false;
        listCursos = response.message;
      });

      return;
    }
  }

  Future<void> loadProgresoAcademico() async {
    dynamic response = await appProvider!.progresoAcademico();
    if (response is Response) {
      listProgresoAcademico = List<dynamic>.from(response.data)
          .map((json) => ProgresoAcademico.fromJson(json))
          .toList();
      print(listProgresoAcademico);
    }

    if (response is RestError) {}
  }

  Future<void> loadPublicacion() async {
    dynamic response = await appProvider!.publicaciones();

    if (response is Response) {
      var data = response.data;
      _generarModales(data);
    }
  }

  void _generarModales(dynamic data) {
    for (var item in data) {
      _showSimpleModalDialog(
        context,
        item["titulo"],
        item["subTitulo"],
        item["mensaje"],
        item["tipoPublicacion"],
      );
    }
  }

  void _showSimpleModalDialog(context, String titulo, String subTitulo,
      String mensaje, bool tipoPublicacion) async {
    Size size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            constraints: BoxConstraints(maxHeight: size.height * 0.8),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      titulo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (subTitulo == "")
                      const SizedBox()
                    else
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  subTitulo,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    if (!tipoPublicacion)
                      Image(
                        image: NetworkImage(mensaje),
                      )
                    else
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              mensaje,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
