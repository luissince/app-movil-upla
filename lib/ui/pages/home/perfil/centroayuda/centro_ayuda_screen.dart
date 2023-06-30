import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_frecuente_screen.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_lista_screen.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

import '../../../../../model/consulta.dart';
import 'widget/button_ca_widget.dart';

class CentroAyudaScreen extends StatefulWidget {
  static String id = "centro_ayuda_page";

  const CentroAyudaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CentroAyudaScreen> createState() => _CentroAyudaScreenState();
}

class _CentroAyudaScreenState extends State<CentroAyudaScreen> {
  AppProvider? appProvider;

  bool loadingInfo = false;
  bool responseOkInfo = false;
  String messageInfo = "";

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
  void dispose() async {
    super.dispose();
    controller.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
      
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "Centro de Ayuda").build(context),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Column(
            children: [
              ButtonCentroAyudaWidget(
                icono: CupertinoIcons.question_circle,
                titulo: "Preguntas frecuentes",
                detalle: "Sobre temas relacionados a la universidad",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CentroAyudaFrecuenteScreen.id,
                  );
                },
              ),
              ButtonCentroAyudaWidget(
                icono: CupertinoIcons.lightbulb,
                titulo: "Déjanos su pregunta",
                detalle: "Un canal de comunicación para responder sus dudas",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CentroAyudaListaScreen.id,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
