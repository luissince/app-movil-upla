import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/respuesta.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/components/alert.dart';

import '../../widget/app_bar_ca_widget.dart';

class CentroAyudaDetalleScreen extends StatefulWidget {
  static String id = "centro_ayuda_detalle_page";

  const CentroAyudaDetalleScreen({Key? key}) : super(key: key);

  @override
  State<CentroAyudaDetalleScreen> createState() =>
      _CentroAyudaDetalleScreenState();
}

class _CentroAyudaDetalleScreenState extends State<CentroAyudaDetalleScreen> {
  AppProvider? appProvider;

  bool loadingConsulta = true;
  bool responseOkConsulta = false;
  String messageConsulta = "";

  bool loadingRespuestas = true;
  bool responseOkRespuestas = false;
  String messageRespuestas = "";

  String ticket = "-";
  String tipo = "-";
  String estado = "-";
  String asunto = "-";
  String descripcion = "-";

  List<Respuesta> listRespuestas = [];

  ScrollController controller = ScrollController();
  int paginacion = 1;
  int filasPorPagina = 15;
  bool hasMore = true;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadConsulta();
      loadRespuestas();
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadRespuestas();
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar:
          AppBarCaWidget(title: "Respuestas - Centro de Ayuda").build(context),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: MainWidget(size),
        ),
      ),
    );
  }

  Widget MainWidget(Size size) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          /**
           * Cabecera
           */
          CabeceraWidget(size),
          /**
           * Contenido
           */
          ContenidoWidget(size)
        ],
      ),
    );
  }

  Widget CabeceraWidget(Size size) {
    if (loadingConsulta) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Column(
          children: [
            ActivityIndicator(
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cargando Consulta...",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    return Container(
      width: size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.lightbulb,
            color: Color(0xffffd42f),
            size: 36,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "¡Hola!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Detalle de su consulta :D.",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  "Ticket:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "N° - $ticket",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
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
                  "Tipo:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  tipo,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
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
                  "Estado:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  estado,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
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
                  "Asunto:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  asunto,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
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
                  "Descripción:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  descripcion,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget ContenidoWidget(Size size) {
    if (loadingRespuestas) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: const Column(
          children: [
            ActivityIndicator(
              color: kPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Cargando Respuestas...",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    if (!responseOkRespuestas) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Icon(
              Icons.warning,
              color: Color.fromRGBO(254, 1, 3, 1),
              size: 37,
            ),
            Text(
              textAlign: TextAlign.center,
              messageRespuestas,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    if (listRespuestas.isEmpty) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Icon(
              CupertinoIcons.ellipses_bubble,
              color: Color.fromARGB(255, 4, 157, 86),
              size: 37,
            ),
            Text(
              textAlign: TextAlign.center,
              messageRespuestas,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    return Expanded(
      child: SizedBox(
        width: size.width,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(0),
            itemCount: listRespuestas.length + 1,
            itemBuilder: (context, index) {
              if (index < listRespuestas.length) {
                Respuesta item = listRespuestas[index];
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ListBody(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_text,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Respuesta",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "${formatDate(item.fecha!)} - ${formatHour(item.hora!)}",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 114, 114, 114),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom: 10.0,
                                      ),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xfff1f1f5),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.detalle!,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: hasMore
                        ? const CircularProgressIndicator()
                        : const Text("No hay mas datos para mostrar."),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget contenRespuesta(Size size, Respuesta respuesta) {
    return Stack(
      children: [
        Positioned(
          left: 15,
          child: Container(
            height: size.height * 0.7,
            width: 1.0,
            color: Colors.grey.shade400,
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(192, 192, 192, 0.3),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.message,
                    color: Color.fromARGB(255, 137, 137, 137),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 11,
                    right: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Respuesta",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 196, 151, 1),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 19,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatDate(respuesta.fecha!),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    formatHour(respuesta.hora!),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        respuesta.detalle!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> loadConsulta() async {
    dynamic response = await appProvider!.obtenerConsultaPorIdConsulta(
      appProvider!.idConsulta,
      cancelToken: cancelToken,
    );

    if (response is Response) {
      setState(() {
        ticket = response.data["ticket"];
        tipo = response.data["tipoConsultaDetalle"];
        estado = response.data["estado_descripcion"];
        asunto = response.data["asunto"];
        descripcion = response.data["descripcion"];

        loadingConsulta = false;
        responseOkConsulta = true;
        messageConsulta = "";
      });
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      Alert(context).showAlert(response.message, callback: () {
        Navigator.pop(context);
      });
    }
  }

  Future<void> loadRespuestas() async {
    Map<String, dynamic> payload = {
      "idConsulta": appProvider!.idConsulta,
      "posPagina": (paginacion - 1) * filasPorPagina,
      "filaPagina": filasPorPagina
    };

    dynamic response = await appProvider!.obtenerRespuestasPorIdConsulta(
      payload,
      cancelToken: cancelToken,
    );

    if (response is Response) {
      List<dynamic> list = response.data;

      setState(() {
        paginacion++;
        if (list.length < filasPorPagina) {
          hasMore = false;
        }

        listRespuestas.addAll(list.map((item) => Respuesta.fromJson(item)));

        loadingRespuestas = false;
        responseOkRespuestas = true;
        messageRespuestas =
            listRespuestas.isEmpty ? "No hay respuestas por el momento." : "";
      });
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        loadingRespuestas = false;
        responseOkRespuestas = false;
        messageRespuestas = response.message;
      });
    }
  }
}
