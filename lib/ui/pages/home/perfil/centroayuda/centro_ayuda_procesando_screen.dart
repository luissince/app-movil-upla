import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:upla/network/exception/rest_error.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/pages/home/perfil/centroayuda/centro_ayuda_respuesta_screen.dart';

class CentroAyudaProcesandoScreen extends StatefulWidget {
  static String id = "centro_ayuda_procesando_page";

  const CentroAyudaProcesandoScreen({Key? key}) : super(key: key);

  @override
  State<CentroAyudaProcesandoScreen> createState() =>
      _CentroAyudaProcesandoScreenState();
}

class _CentroAyudaProcesandoScreenState
    extends State<CentroAyudaProcesandoScreen> {
  AppProvider? appProvider;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _procesarPeticion();
    });
  }

  @override
  void dispose() async {
    super.dispose();
    cancelToken.cancel();
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
                  SizedBox(
                    height: 20,
                  ),
                  ActivityIndicator(
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Procesando registro...",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
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

  void _procesarPeticion() async {
    dynamic response = await appProvider!.registrarConsulta(
      appProvider!.payload,
      cancelToken: cancelToken,
    );

    if (response is Response) {
      appProvider!.response = {
        "state": true,
        "message": response.data,
      };

      Navigator.pushReplacementNamed(
        context,
        CentroAyudaRespuestaScreen.id,
      );
    }

    if (response is RestError) {
      if (response.type == DioErrorType.cancel) return;

      appProvider!.response = {
        "state": false,
        "message": response.message,
      };

      Navigator.pushReplacementNamed(
        context,
        CentroAyudaRespuestaScreen.id,
      );
    }
  }
}
