import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upla/constants.dart';
import 'package:upla/ui/components/activity_indicator.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/respuesta_pago_tramite_screen.dart';

class ProcesandoPagoTramiteScreen extends StatefulWidget {
  static String id = "procesando_pago_tramite_page";

  const ProcesandoPagoTramiteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProcesandoPagoTramiteScreen> createState() =>
      _ProcesandoPagoTramiteScreenState();
}

class _ProcesandoPagoTramiteScreenState
    extends State<ProcesandoPagoTramiteScreen> {
  @override
  void initState() {
    sleepWidget();

    super.initState();
  }

  void sleepWidget() {
    Future.delayed(
      const Duration(seconds: 6),
      () async {
        Navigator.pushReplacementNamed(
          context,
          RespuestaPagoTramiteScreen.id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    "Procesando pago...",
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
}
