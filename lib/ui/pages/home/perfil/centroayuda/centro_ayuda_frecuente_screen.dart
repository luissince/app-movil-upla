import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/frecuente.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

import 'widget/button_ca_frecuente_widget.dart';

class CentroAyudaFrecuenteScreen extends StatefulWidget {
  static String id = "centro_ayuda_frecuente_page";

  const CentroAyudaFrecuenteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CentroAyudaFrecuenteScreen> createState() =>
      _CentroAyudaFrecuenteScreenState();
}

class _CentroAyudaFrecuenteScreenState
    extends State<CentroAyudaFrecuenteScreen> {
  AppProvider? appProvider;

  bool cargando = true;
  bool respuesta = false;
  String mensaje = "";
  List<Frecuente> frecuentes = [];

  ScrollController controller = ScrollController();
  int paginacion = 1;
  int filasPorPagina = 15;
  bool hasMore = true;

  bool expanded = false;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadFrecuentes();
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadFrecuentes();
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
      backgroundColor: Colors.white,
      appBar: AppBarCaWidget(title: "Preguntas frecuentes").build(context),
      body: AnnotateRegionWidget(children: _main(size)).build(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _main(Size size) {
    if (cargando) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: Colors.white,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

    if (!respuesta) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: Color.fromRGBO(254, 1, 3, 1),
              size: 37,
            ),
            Text(
              textAlign: TextAlign.center,
              mensaje,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: size.width,
            child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(0),
                itemCount: frecuentes.length + 1,
                itemBuilder: (context, index) {
                  if (index < frecuentes.length) {
                    Frecuente frecuente = frecuentes[index];
                    return ButtonCaFrecuenteWidget(
                      titulo: frecuente.asunto,
                      detalle: frecuente.descripcion,
                      expanded: frecuente.expandir,
                      onPressed: () {
                        setState(() {
                          frecuente.expandir = !frecuente.expandir;
                        });
                      },
                      context: context,
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
                }),
          ),
        ),
      ],
    );
  }

  Future<void> loadFrecuentes() async {
    Map<String, dynamic> payload = {
      "buscar": "",
      "posPagina": (paginacion - 1) * filasPorPagina,
      "filaPagina": filasPorPagina
    };

    dynamic response = await appProvider!.listarFrecuentes(
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

        frecuentes.addAll(list.map((item) => Frecuente.fromJson(item)));

        cargando = false;
        respuesta = true;
        mensaje = "";
      });
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      setState(() {
        frecuentes = [];
        cargando = false;
        respuesta = false;
        mensaje = response.message;
      });
    }
  }
}
