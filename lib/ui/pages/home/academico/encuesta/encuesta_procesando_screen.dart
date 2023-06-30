import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:upla/constants.dart';
import 'package:upla/model/encuesta_pregunta.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuesta_respuesta_screen.dart';

class EncuestaProcesandoScreen extends StatefulWidget {
  static String id = "encuesta_procesando_page";

  const EncuestaProcesandoScreen({Key? key}) : super(key: key);

  @override
  State<EncuestaProcesandoScreen> createState() => _EncuestaProcesandoState();
}

class _EncuestaProcesandoState extends State<EncuestaProcesandoScreen> {
  AppProvider? appProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      procesarPeticion();
    });
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/logo_only_white.svg",
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ActivityIndicator(
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Procesando encuesta...",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Espere por favor.",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void procesarPeticion() async {
    // try {
    EncuestaPregunta encuestaPregunta = EncuestaPregunta(
      appProvider!.session.docNumId!,
      appProvider!.listaEncuestaPregunta,
    );

    dynamic response =
        await appProvider!.estudianteRegistrarEncuenta(encuestaPregunta);

    if (response is Response) {
      _navegarRespuesta(true, response.data);
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      _navegarRespuesta(false, response.message);
    }
  }

  void _navegarRespuesta(bool state, String message) {
    appProvider!.response = {
      "state": state,
      "response": message,
    };

    Navigator.pushReplacementNamed(context, EncuestaRespuestaScreen.id);
  }
}
