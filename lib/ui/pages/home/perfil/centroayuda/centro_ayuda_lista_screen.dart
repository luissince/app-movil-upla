import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_crear_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_detalle_screen.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

import '../../../../../constants.dart';
import '../../../../../model/consulta.dart';

class CentroAyudaListaScreen extends StatefulWidget {
  static String id = "centro_ayuda_lista_page";

  const CentroAyudaListaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CentroAyudaListaScreen> createState() => _CentroAyudaListaScreenState();
}

class _CentroAyudaListaScreenState extends State<CentroAyudaListaScreen> {
  AppProvider? appProvider;

  bool loadingConsulta = false;
  bool responseOkConsulta = false;
  String messageConsulta = "";
  List<Consulta> items = [];

  ScrollController controller = ScrollController();
  int paginacion = 1;
  int filasPorPagina = 15;
  bool hasMore = true;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadConsultas();
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadConsultas();
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
    Size size = MediaQuery.of(context).size;

    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Déjanos un comentario").build(context),
      body: AnnotateRegionWidget(children: _main(size)).build(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => Navigator.pushNamed(
          context,
          CentroAyudaCrearScreen.id,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _main(Size size) {
    return RefreshIndicator(
      onRefresh: () async {
        loadConsultas();
      },
      child: Container(
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
            _contenedorTitulo(size),
            /**
             * Contenido
             */
            _contenedorDetalle(size)
          ],
        ),
      ),
    );
  }

  Widget _contenedorTitulo(Size size) {
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
          Text(
            "${appProvider!.session.persNombre}, ${appProvider!.session.persPaterno} ${appProvider!.session.persMaterno}",
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Puede consultar sus preguntas echas, en cualquier momento.",
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _contenedorDetalle(Size size) {
    if (!loadingConsulta && !responseOkConsulta) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Column(
          children: [
            ActivityIndicator(color: kPrimaryColor),
            SizedBox(
              height: 10,
            ),
            Text(
              "Generando vista.",
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

    if (loadingConsulta) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: const Column(
          children: [
            ActivityIndicator(color: kPrimaryColor),
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
        ),
      );
    }

    if (!responseOkConsulta) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            const Icon(
              Icons.warning,
              color: Color.fromRGBO(254, 1, 3, 1),
              size: 37,
            ),
            Text(
              textAlign: TextAlign.center,
              messageConsulta,
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
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                Consulta item = items[index];
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ListBody(
                      children: [
                        _contenedorItem(item),
                      ],
                    ),
                  ),
                  onTap: () {
                    appProvider!.idConsulta = item.idConsulta;
                    Navigator.pushNamed(
                      context,
                      CentroAyudaDetalleScreen.id,
                    );
                  },
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

  Widget _contenedorItem(Consulta item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              CupertinoIcons.doc_chart,
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
              Text(
                "N° Ticket: ${item.ticket}",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                item.asunto,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${formatDate(item.fecha)} - ${formatHour(item.hora)}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 94, 94, 94),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        item.tipoConsultaDetalle,
                        style: const TextStyle(
                          color: Color.fromARGB(
                            255,
                            51,
                            51,
                            51,
                          ),
                          fontSize: 11,
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
    );
  }

  Future<void> loadConsultas() async {
    Map<String, dynamic> payload = {
      "codigo": appProvider!.session.docNumId,
      "posPagina": (paginacion - 1) * filasPorPagina,
      "filaPagina": filasPorPagina
    };

    dynamic response = await appProvider!.listarConsultasPorIdEst(
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

        items.addAll(list.map((item) => Consulta.fromJson(item)));

        loadingConsulta = false;
        responseOkConsulta = true;
        messageConsulta = "";
      });
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        items = [];
        loadingConsulta = false;
        responseOkConsulta = false;
        messageConsulta = response.message;
      });
    }
  }
}
